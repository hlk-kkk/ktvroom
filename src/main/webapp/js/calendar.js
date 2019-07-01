/**
 * javascript�����ؼ�
 * @author tugenhua
 */

function Calendar(options, callback) {
    var self = this;
    self.options = $.extend({}, defaults, options || {});
    self.targetCls = $(self.options.targetCls);
    if (self.targetCls.length < 1) {
        return;
    }
    self.language = self.options.language;

    // ��ʾ�������
    self.flag = false;

    self.callback = callback;

    self._init();
    self._bindEnv();

};
$.extend(Calendar.prototype, {

    _init: function () {
        var self = this;
        // ����Ⱦ�������
        self._renderCalendarPanel();
    },
    _renderCalendarPanel: function () {
        var self = this,
            options = self.options;
        // ���input����������ڵĻ�
        if (self.targetCls.val().length > 0) {
            self.date = self._dateParse(self.targetCls.val());
        }
        self.date = new Date(self.date);
        if (isNaN(self.date.getFullYear())) {
            self.date = new Date();
        }
        var defYear = self.date.getFullYear(),
            defMonth = self.date.getMonth() + 1;

        // ����ÿ�µ�����
        self.month_day = new Array(31, 28 + self._leapYear(defYear), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

        // ����ÿ�ܵ�����
        self.date_name_week = self.language.weekList;

        // ������ĩ
        var saturday = 6 - options.wdays,
            sunday = (7 - options.wdays >= 7) ? 0 : (7 - options.wday);

        // �����������dom�ڵ�
        var date_pane = $('<div class="cxcalendar"></div>'),
            date_hd = $('<div class="date_hd"></div>').appendTo(date_pane),
            date_table = $('<table class="date_table"></table>').appendTo(date_pane);

        // type Ϊ yyyy-mm-dd ʱ�� �Ͳ���ʾʱ��
        if (options.type == 'yyyy-mm-dd HH:MM' || options.type == 'yyyy-mm-dd HH:MM:SS') {
            var date_time = $('<div class="date_time"><span class="spinner"><input type="text" class="spinner-text"><i class="spinner-arrow spinner-arrow-up"></i><i class="spinner-arrow spinner-arrow-down"></i></span></div>')
                .appendTo(date_pane);
        }
        var date_button = $('<div class="date_button"><a href="javascript:void(0)" class="date-current">����</a><a href="javascript:void(0)" class="date-closed">�ر�</a><a href="javascript:void(0)" class="date-ok">ȷ��</a></div>').appendTo(date_pane);
        date_hd.html("<a class='date_pre' href='javascript://' rel='prev'>&lt;</a><a class='date_next' href='javascript://' rel='next'>&gt;</a>");

        var date_txt = $('<div class="date_txt"></div>').appendTo(date_hd),
            date_set = $('<div class="date_set"></div>').appendTo(date_hd),
            html = "";

        for (var i = options.beginyear; i < options.endyear; i++) {
            html += "<option value='" + i + "'>" + i + "</option>";
        }
        var year_list = $('<select class="year_set"></select>').html(html).appendTo(date_set).val(defYear);

        date_set.append(" - ");
        html = '';
        for (var i = 0; i < 12; i++) {
            html += '<option value="' + (i + 1) + '">' + self.language.monthList[i] + '</option>';
        }
        var month_list = $('<select class="month_set"></select>').html(html).appendTo(date_set).val(defMonth);
        html = '<thead><tr>';
        // ����һ��7��
        for (var i = 0; i < 7; i++) {
            html += "<th class='"
            // ��ĩ����
            if (i == saturday) {
                html += " sat";
            } else if (i == sunday) {
                html += " sun";
            }
            ;
            html += "'>";
            html += (i + options.wday * 1 < 7) ? self.date_name_week[i + options.wday] : self.date_name_week[i + options.wday - 7];
            html += "</th>";
        }
        ;
        html += "</tr></thead>";
        html += "<tbody></tbody>";
        date_table.html(html);

        // ��弰�����ڵ�����뵽ҳ����
        date_pane.appendTo("body");

        // �������ֲ��Ŀ���ǣ�ֻ��ʾһ���������
        var block_bg = $("<div class='cxcalendar_lock'></div>").appendTo("body");

        // ��ֵ ȫ��
        self.dateTxt = date_txt;
        self.yearList = year_list;
        self.monthList = month_list;
        self.dateTable = date_table;
        self.saturday = saturday;
        self.sunday = sunday;
        self.datePane = date_pane;
        self.blockBg = block_bg;
        self.dateSet = date_set;
        self.defYear = defYear;
        self.defMonth = defMonth;
        self.dateTime = date_time;

        //  ���ݵ�ǰ��ʱ�� ��Ⱦʱ����
        self._renderTime(self.date);

        // ������� �·�����Ⱦ��
        self._renderBody(defYear, defMonth);
    },
    // ���� ���·ֵ� ����
    _dayNumOfMonth: function (Year, Month) {
        var d = new Date(Year, Month, 0);
        return d.getDate();
    },
    /*
     * ���ݵ�ǰ��ʱ�䣬��Ⱦʱ����
     */
    _renderTime: function (date) {
        var self = this,
            options = self.options;
        var hours = new Date(date).getHours(),
            minutes = new Date(date).getMinutes(),
            seconds = new Date(date).getSeconds(),
            curTime;
        if (hours < 10) {
            hours = '0' + hours;
        }
        if (minutes < 10) {
            minutes = '0' + minutes;
        }
        if (seconds < 10) {
            seconds = '0' + seconds;
        }
        if (options.type == 'yyyy-mm-dd HH:MM:SS') {
            curTime = hours + ":" + minutes + ":" + seconds;

        } else if (options.type == 'yyyy-mm-dd HH:MM') {
            curTime = hours + ":" + minutes;

        }

        $(self.dateTime).find('.spinner-text').val(curTime);
    },
    /*
     * ��Ⱦ��������
     * @param {y,m} �� ��
     */
    _renderBody: function (y, m) {
        var self = this;
        var options = self.options;
        if (m < 1) {
            y--;
            m = 12;
        } else if (m > 12) {
            y++;
            m = 1;
        }
        var tempM = m,
            cur_m = m;

        m--;  // �·ݴ�0��ʼ��
        var prevMonth = tempM - 1,  //�ϸ��µ��·�
            prevDay = self._dayNumOfMonth(y, tempM - 1), // �ϸ��µ�����
            nextMonth = tempM + 1,   // �¸��µ��·�
            nextDay = self._dayNumOfMonth(y, tempM + 1),  //�¸��µ�����
            curDay = self._dayNumOfMonth(y, tempM);       // ��ǰ�·ݵ�����

        self.month_day[1] = 28 + self._leapYear(y);  //����Ļ� 29�� ���� 28��
        var temp_html = "",
            temp_date = new Date(y, m, 1);
        var now_date = new Date();
        now_date.setHours(0);
        now_date.setMinutes(0);
        now_date.setSeconds(0);

        // ����������ֵ�Ļ�
        if (self.targetCls.val().length > 0) {
            var val_date = self._dateParse(self.targetCls.val())
        }
        val_date = new Date(val_date);
        if (isNaN(val_date.getFullYear())) {
            val_date = null;
        }
        ;
        // ��ȡ���µĵ�һ��
        var firstDay = temp_date.getDay() - options.wday < 0 ?
            temp_date.getDay() - options.wday + 7 :
            temp_date.getDay() - options.wday;


        // ÿ������Ҫ������
        var monthRows = Math.ceil((firstDay + self.month_day[m]) / 7);
        var td_num,
            day_num,
            diff_now,
            diff_set;
        var disabled;
        for (var i = 0; i < monthRows; i++) {
            temp_html += "<tr>";
            for (var j = 0; j < 7; j++) {
                td_num = i * 7 + j;
                day_num = td_num - firstDay + 1;
                if (day_num <= 0) {
                    if (day_num == 0) {
                        day_num = prevDay - day_num
                        text_m = prevMonth
                    } else {
                        day_num = prevDay + day_num;
                        text_m = prevMonth
                    }

                } else if (day_num > self.month_day[m]) {
                    day_num = day_num - curDay;
                    text_m = nextMonth
                } else {
                    text_m = cur_m;
                }
                temp_html += "<td";
                if (typeof (day_num) == 'number') {
                    diff_now = null;
                    diff_set = null;
                    temp_date = new Date(y, m, day_num);

                    if (text_m == cur_m) {
                        diff_now = Date.parse(now_date) - Date.parse(temp_date);
                        diff_set = Date.parse(val_date) - Date.parse(temp_date);
                    }
                    if (cur_m > text_m || cur_m < text_m) {
                        disabled = 'disabled';
                    } else {
                        disabled = "";
                    }
                    temp_html += (" title='" + y + options.separator + tempM + options.separator + day_num + "' class='num " + disabled + "");

                    // ������ĩ�����졢ѡ��
                    if (diff_set == 0) {    //ѡ�е�ʱ�� ����select ����
                        temp_html += " selected";
                    } else if (diff_now == 0) {
                        temp_html += " now";   // ��ǰʱ������now����
                    } else if (j == self.saturday) {
                        temp_html += " sat";   // ��������sat����
                    } else if (j == self.sunday) {
                        temp_html += " sun";   // ��������sun����
                    }
                    ;
                    temp_html += ("'");
                }
                ;
                temp_html += (" date-day='" + day_num + "'>" + day_num + "</td>");
            }
            temp_html += "</tr>";
        }

        $(self.dateTable).find("tbody").html(temp_html);
        $(self.dateTxt).html("<span class='y'>" + y + "</span>" + options.language.year + "<span class='m'>" + options.language.monthList[m] + "</span>" + options.language.month);
        $(self.yearList).val(y);
        $(self.monthList).val(m + 1);

        return this;
    },
    _dateParse: function (date) {
        var newdate = date;
        newdate = newdate.replace(/\./g, "/");
        newdate = newdate.replace(/-/g, "/");
        newdate = newdate.replace(/\//g, "/");
        newdate = Date.parse(newdate);
        return newdate;
    },
    /*
     * �ж��Ƿ�������
     * @param y ���
     * 1.�ܱ�4�����Ҳ��ܱ�100���� 2.�ܱ�100�������ܱ�400����
     */
    _leapYear: function (y) {
        return ((y % 4 == 0 && y % 100 != 0) || y % 400 == 0) ? 1 : 0;
    },
    _bindEnv: function () {
        var self = this;
        var options = self.options;
        $(self.targetCls).unbind('click').bind('click', function () {
            self.show();

            // ��Ⱦʱ����
            self._renderTime(new Date());
        });

        // �ر�����¼�
        self.blockBg.unbind('click').bind("click", function () {
            self.hide();
        });

        // �����һҳ ��һҳ�¼�
        self.datePane.delegate('a', 'click', function () {
            if (!this.rel) {
                return
            }
            ;
            var _rel = this.rel;
            if (_rel == 'prev') {
                self._renderBody(self.yearList.val(), parseInt(self.monthList.val(), 10) - 1);
                return;
            } else if (_rel == 'next') {
                self._renderBody(self.yearList.val(), parseInt(self.monthList.val(), 10) + 1);
                return;
            }
        });

        // ѡ�������¼�
        self.datePane.delegate('td', 'click', function () {
            var _this = $(this);
            if (_this.hasClass('num') && !_this.hasClass('disabled')) {
                self.dateTable.find("td").removeClass("selected");
                _this.addClass("selected");
                var day = _this.attr("date-day");
                if (options.type == 'yyyy-mm-dd') {
                    self._selectDay(day);
                }

            }
        });

        // ��ʾ����ѡ��
        self.dateTxt.unbind('click').bind("click", function () {
            self.dateTxt.hide();
            self.dateSet.show();
        });

        //���������¼�
        self.yearList.unbind('change').bind("change", function () {
            self._renderBody(self.yearList.val(), self.monthList.val());
        });
        self.monthList.unbind('change').bind("change", function () {
            self._renderBody(self.yearList.val(), self.monthList.val());
        });

        // ���ȷ����ť
        self.datePane.delegate('.date-ok', 'click', function () {
            var nums = $(self.dateTable).find('.num'),
                flag = false;
            for (var i = 0, ilen = nums.length; i < ilen; i++) {
                if ($(nums[i]).hasClass("selected")) {
                    var day = $(nums[i]).attr("date-day");
                    flag = true;
                    break;
                } else {
                    if ($(nums[i]).hasClass("now")) {
                        var day = $(nums[i]).attr("date-day");
                        flag = true;
                        continue;
                    }
                }
            }
            if (flag) {
                self._selectDay(day);
            }
        });
        // ����رհ�ť
        self.datePane.delegate('.date-closed', 'click', function () {
            self.hide();
        });

        // ������찴ť
        self.datePane.delegate('.date-current', 'click', function () {
            // ��ȡ��ǰ�ڼ���
            var date = new Date(),
                curDay = date.getDate(),
                curYear = date.getFullYear(),
                curMonth = date.getMonth() + 1;
            self._renderBody(curYear, curMonth);

            self.dateTable.find("td.num").removeClass("selected");
            self.dateTable.find("td.num").each(function () {
                var day = $(this).attr("date-day");
                if (day == curDay) {
                    $(this).addClass("selected");
                }
            });
        });

        // �����ͷ���ϰ�ť
        self.datePane.delegate('.spinner-arrow-up', 'click', function () {
            self._inputValChange(true);
        });

        // �����ͷ���°�ť
        self.datePane.delegate('.spinner-arrow-down', 'click', function () {
            self._inputValChange(false);
        });
    },
    /*
     * ѡ��ĳһ���ʱ�� ��ֵ����������� ���������
     * @_selectDay {private}
     */
    _selectDay: function (d) {
        var self = this;
        var year,
            month;
        month = self.monthList.val();
        day = d;
        var options = self.options;
        month = "0" + self.monthList.val();
        day = "0" + d;
        month = month.substr((month.length - 2), month.length);
        day = day.substr((day.length - 2), day.length);

        if (options.type == 'yyyy-mm-dd') {
            self.targetCls.val(self.yearList.val() + options.separator + month + options.separator + day);
            self.hide();
            self.callback && $.isFunction(self.callback) && self.callback(self.yearList.val() + options.separator + month + options.separator + day);
        } else if (options.type == 'yyyy-mm-dd HH:MM:SS' || options.type == 'yyyy-mm-dd HH:MM') {
            self.targetCls.val(self.yearList.val() + options.separator + month + options.separator + day + " " + $(self.dateTime).find('.spinner-text').val());
            self.hide();
            self.callback && $.isFunction(self.callback) && self.callback(self.yearList.val() + options.separator + month + options.separator + day + " " + $(self.dateTime).find('.spinner-text').val());
        }
        return this;
    },
    /*
     * ������ϻ������� ʱ�������ֵ�ı�
     * @param {flag} boolean �����͡����Ϊtrue �������ϼ� ���������¼�
     */
    _inputValChange: function (flag) {
        var self = this,
            options = self.options;

        var inputVal = $(self.datePane).find('.spinner-text').val();
        var arrs = inputVal.split(":"),
            hour = arrs[0] ? arrs[0] : '',
            minute = arrs[1] ? arrs[1] : '',
            second = arrs[2] ? arrs[2] : '';
        if (flag) {
            hour++;
            if (hour >= 24) {
                return;
            } else if (hour < 10) {
                hour = "0" + hour;
            }
        } else {
            hour--;
            if (hour < 0) {
                return;
            } else if (hour < 10) {
                hour = '0' + hour;
            }
        }
        var val;
        if (options.type == "yyyy-mm-dd HH:MM:SS") {
            val = hour + ":" + minute + ":" + second;

        } else if (options.type == 'yyyy-mm-dd HH:MM') {
            val = hour + ":" + minute;

        }
        $('.spinner-text', self.datePane).val(val);

    },
    /*
     * ��ʾ�������
     * @method  show {public}
     */
    show: function () {
        var self = this;
        if (self.flag) {
            return;
        }
        var doc_w = document.body.clientWidth,
            doc_h = document.body.clientHeight,
            pane_top = self.targetCls.offset().top,
            pane_left = self.targetCls.offset().left,
            obj_w = self.targetCls.outerWidth(),
            obj_h = self.targetCls.outerHeight();
        pane_top = pane_top + obj_h;
        self.datePane.css({"top": pane_top, "left": pane_left}).show();
        self.blockBg.css({width: doc_w, height: doc_h}).show();
        self.flag = true;
        return this;
    },
    /*
     * �������
     * @method clear {public}
     */
    clear: function () {
        var self = this;
        self.targetCls.val('');
        self._renderBody(self.defYear, self.defMonth);
        self.hide();
        return this;
    },
    /*
     * ��ȡ��ǰѡ�е�����
     * @method getValue {public}
     * @return val
     */
    getValue: function () {
        var self = this;
        return self.targetCls.val();
    },
    /*
     * �����������
     */
    hide: function () {
        var self = this;
        if (!self.flag) {
            return;
        }
        self.datePane.hide();
        self.blockBg.hide();
        self.dateSet.hide();
        self.dateTxt.show();
        self.flag = false;
        return this;
    }
});

var defaults = {
    targetCls: '',             //��Ⱦ������class
    beginyear: 1949,           //��ʼ���
    endyear: 2050,           //�������
    date: new Date(),     // Ĭ������
    type: "yyyy-mm-dd",	  // ���ڸ�ʽ
    separator: "-",			  // �������ӷ�
    wday: 0,			  // �ܵ�һ��
    language: {
        year: "��",
        month: "��",
        monthList: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
        weekList: ["��", "һ", "��", "��", "��", "��", "��"]
    }
};