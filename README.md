## Automatic Video Recorder for Raspberry Pi

To enable automatic video recording when Raspberry Pi is booted (if the camera is connected to the device) you need:

```bash
git clone https://github.com/dmytrodor/auto-video-recorder
cd auto-video-recorder
```

Next, you need to setup everything (copy some scripts and create a service):

```bash
sudo bash setup.sh
```

And that's it! Now when your Raspberry Pi is booted it automatically will create a directory `/home/<user>/Videos` and will record a video (in the format `<number>.ts`).