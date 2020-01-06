Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225F71312CB
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2020 14:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFN1z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jan 2020 08:27:55 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37314 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFN1z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jan 2020 08:27:55 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so42562336iln.4
        for <linux-spi@vger.kernel.org>; Mon, 06 Jan 2020 05:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=syscall7-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZeVJt3rogr58PUxvMRMdzvdltpF3JtyG/1aZqwJSL4=;
        b=ygHuSNeWGGtu6MDURspWPhUCpJz1VDGBzlCKS+am9ZMy81+qlIKjI+yevBcEOmGBjZ
         RiXV1FlGCo94mmh9QnCezuits1LQTFIA0PrsWO1I6lUURZy5CgOXEpDNjQs7vp2Avoj3
         7tC9hhMLPq1/i/r6r2heDg7h1QTujI8z55ARNASJ3vAiRrNb1AJSBfc9o2gd97yzQi7o
         a6LfAQCT7nTc5YppOkFLNJ/WMkZj0P6cQ4vmDyp3/sD9ni8q2sj/VVn7zT6LJHQsOVsZ
         qmUHmtuSmneNfFtvbtBN2moofN68imLzCQvMMdXIAloRXcK+KfGeusCQ+TcnzX9Pl6II
         LYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZeVJt3rogr58PUxvMRMdzvdltpF3JtyG/1aZqwJSL4=;
        b=Trqe85vTx7QGpFQxCf4pHg6YhAGACDiurLGshjtLEtdUw6WdAXS4Hhi0sbHOaFmfl1
         ZORVe2V+qWFy6SzuQQbMDeKifI/QvWnAnxNmZSLScEqzqVpupbHzOgeMeFbm2t9otJRP
         ULoxLkyyLdmkNt+eEIWC00oXXdH6i5ustQNhrSsoVUIG7PHK+PlnAvAfOiIojgnP+RZ1
         i2Kib7QeMXwPEjWSVmhsr1OFTgWt8Lg3aGneci1+BEOiUUqkrMwFdADgbcQqrHjZElkS
         gwc8MCIrLikYVRn8Tm5umuAR2/3J19PcoaWdPeIBMTbuQEhY/oP1bzzALtEd+2ONqMGl
         Z3Hg==
X-Gm-Message-State: APjAAAV/nZsHWe223XB5mJT2I/kxXObc+lHZgj3l9NlqKOyyOP0/P3Iz
        InyWouyjPUG80UrTDAIbw3R68JrvFKEIIK4NSXElrOYHeg0NFw==
X-Google-Smtp-Source: APXvYqzSpIuJ+EDL6HP1j0BLMfzvQq8SbFF3NQ4NNj9iN2wLzPQVx8KwsGAgUIsJ7M/cGZm4he0TpXWn9JUBKiNbjp8=
X-Received: by 2002:a92:3a9b:: with SMTP id i27mr90682231ilf.39.1578317274255;
 Mon, 06 Jan 2020 05:27:54 -0800 (PST)
MIME-Version: 1.0
References: <CAB595VxuL+iOQD3Re1PbjP50GD51XuMML8_R6Ku2ywAAHcOcdw@mail.gmail.com>
 <a0171241162171ffac6429d29edfaa83fbd9a2ba.camel@alliedtelesis.co.nz>
In-Reply-To: <a0171241162171ffac6429d29edfaa83fbd9a2ba.camel@alliedtelesis.co.nz>
From:   Anthony DeRosa <anthony.derosa@syscall7.com>
Date:   Mon, 6 Jan 2020 08:27:43 -0500
Message-ID: <CAB595VzfMRU4Pejuzi0jODvu9p_mh473-cdK92jxSxk3yPHtqw@mail.gmail.com>
Subject: Re: Multiplex SPI Chip Selects
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chris,

Thanks for your response. The cs-gpios are not sufficient for me,
because the cs-gpios provide N more chip selects, but we need 2^N more
chip selects. We are using a 4:16 address decoder that is controlled
by GPIOs to extend the number of chip selects available like this
(requires fixed-width font to view):

+      MOSI /--------------------------------+--------+--------+--------\
+      MISO |/------------------------------+|-------+|-------+|-------\|
+       SCL ||/----------------------------+||------+||------+||------\||
+           |||                            |||      |||      |||      |||
+    +------------+                        |||      |||      |||      |||
+    | SoC  |||   |                      +-+++-+  +-+++-+  +-+++-+  +-+++-+
+    |      |||   |                      | dev |  | dev |  | dev |  | dev |
+    |   +--+++-+ | CS-X  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
+    |   | SPI  +-|-------+ Mux  |\\   CS-0 |        |        |        |
+    |   +------+ |       +--++--+\\\-------/   CS-1 |        |        |
+    |            |          ||   \\\----------------/   CS-2 |        |
+    |   +------+ |          ||    \\-------------------------/   CS-3 |
+    |   | GPIO +-|----------/|     \----------------------------------/
+    |   |      +-|-----------/
+    |   +------+ |
+    +------------+

This proposed patch does exactly what I need to do:
https://patchwork.kernel.org/patch/2706151/, but I was wondering why
nothing like this already exists or why that patch had not been
included in the mainline kernel.

Best,

Anthony

Anthony V. DeRosa
Principal
Ph. 410-671-5389
anthony.derosa@syscall7.com


10015 Old Columbia Rd. Suite B215
Columbia, MD 21046


On Sun, Jan 5, 2020 at 3:47 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
>
> Hi Anthony,
>
> On Wed, 2020-01-01 at 09:21 -0500, Anthony DeRosa wrote:
> > Hi Chris,
> >
> > I saw your thread[1] about multiplexing chip selects on the SPI bus
> > and wondered what solution you settled on in the end. Looks like your
> > patch was not integrated into the kernel, is that right? I have a
> > similar problem where I need to use GPIOs to multiplex the CS0 pin on
> > a raspberry pi. Any insights would be appreciated.
> >
>
> For the simple case the existing cs-gpios support works well. So using
> that if you can is my recommendation.
>
> Unfortunately for me it's not that simple because I have 2 platforms
> which need both the gpio CS and the native CS0. This is where things
> get a bit tricky.
>
> The existing code will invert the native CS0 (because SPI_CS_HIGH is
> set) I think this is a straight corner-case bug and we should either
> not invert the native CS0 or have a separate flag to indicate when the
> native CS0 needs inverting.
>
> For the 2 platforms I'm dealing with I have a complication in the HW
> design where the gpio is used to steer the native CS0 (as opposed to
> replacing it) which is what my original series attempted to deal with.
> I ended up implementing a gpio-over-gpio controller that presented 2
> virtual gpios which reflected the high-low state of a single physical
> gpio (basically implemented Mark's suggestion from the thread). I
> haven't attempted to upstream the driver because I consider it a SW fix
> for quirk of our HW designs, but if there is interest I could at least
> send it out.
>
> Regards,
> Chris
>
> --
> [1] -
> https://lwn.net/ml/devicetree/20190412050213.17698-1-chris.packham@alliedtelesis.co.nz/
