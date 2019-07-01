package com.hlk.ktvroom.entity;

import java.io.Serializable;
import java.util.List;

public class Menu implements Serializable {
    private Integer id;
    private String title;
    private String iconCls;
    private String href;
    private List<Menu> children;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getIconCls() {
        return iconCls;
    }

    public void setIconCls(String iconCls) {
        this.iconCls = iconCls;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public List<Menu> getChildren() {
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    public Menu() {
        super();
        // TODO Auto-generated constructor stub
    }

    public Menu(Integer id, String title, String iconCls, String href,
                List<Menu> children) {
        super();
        this.id = id;
        this.title = title;
        this.iconCls = iconCls;
        this.href = href;
        this.children = children;
    }

    @Override
    public String toString() {
        return "Menu [id=" + id + ", title=" + title + ", iconCls=" + iconCls
                + ", href=" + href + ", children=" + children + "]";
    }

}
