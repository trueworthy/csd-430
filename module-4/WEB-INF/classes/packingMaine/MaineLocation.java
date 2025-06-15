package packingMaine;

import java.io.Serializable;

public class MaineLocation implements Serializable {
    private String place;
    private String activityType;
    private String description;
    private String season;
    private String region;

    // No-arg constructor
    public MaineLocation() {
    }

    // Full constructor
    public MaineLocation(String place, String activityType, String description, String season, String region) {
        this.place = place;
        this.activityType = activityType;
        this.description = description;
        this.season = season;
        this.region = region;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSeason() {
        return season;
    }

    public void setSeason(String season) {
        this.season = season;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }
}
