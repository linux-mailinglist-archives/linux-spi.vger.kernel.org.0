Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426D63BA47
	for <lists+linux-spi@lfdr.de>; Mon, 10 Jun 2019 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfFJRDu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Jun 2019 13:03:50 -0400
Received: from server101.serverconfig.center ([195.242.103.101]:50035 "EHLO
        server101.serverconfig.center" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725270AbfFJRDu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Jun 2019 13:03:50 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 13:03:49 EDT
Received: from christian-pc.localdomain (p54A59287.dip0.t-ipconnect.de [84.165.146.135])
        by server101.serverconfig.center (Postfix) with ESMTPSA id 3BAC12381D55
        for <linux-spi@vger.kernel.org>; Mon, 10 Jun 2019 18:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-mauderer.de;
        s=default; t=1560185789;
        bh=IODfGsfOvXZ+NtdkIoKiVHRcu6oxlD6o3v0Gi5MnqBw=; l=1450;
        h=From:Subject:To;
        b=XoCuZKXQkiqp4bDJUgnbnbZBnMvWws86oR/mG56dDwXnxR8StAPvVrlqNLUoU9oK2
         RPX9+Qb2OxRdw9AB1zwoeSnzmtehhROIgMTPfqoN0zxMaOD4x2vkPGvuENkIovEcA2
         +2DVQlNI3uO/v/s+UfHDnL7y8mKPad/IZQz7CQxA=
Authentication-Results: server101.serverconfig.center;
        spf=pass (sender IP is 84.165.146.135) smtp.mailfrom=oss@c-mauderer.de smtp.helo=christian-pc.localdomain
Received-SPF: pass (server101.serverconfig.center: connection is authenticated)
From:   Christian Mauderer <oss@c-mauderer.de>
Subject: spi-gpio too fast for some devices
To:     linux-spi@vger.kernel.org
Message-ID: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
Date:   Mon, 10 Jun 2019 18:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <156018578951.129032.12641371879720637066@server101.serverconfig.center>
X-PPP-Vhost: c-mauderer.de
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I have a problem with the spi-gpio driver: It's too fast for one of my
devices. Now I'm searching for a good solution that could be
acceptable as a patch for the Linux kernel.

Currently there is the following comment and implementation for the
spidelay(...) function in spi-gpio.c:

> /*
>  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
>  * requested device clock.  Software overhead means we usually have trouble
>  * reaching even one Mbit/sec (except when we can inline bitops), so for now
>  * we'll just assume we never need additional per-bit slowdowns.
>  */
> #define spidelay(nsecs)	do {} while (0)

With that I have a speed of about 2.2MHz on a QCA9533 chip with 650MHz
using a 4.14 Kernel. The spidelay hasn't been changed in a newer
kernel so I assume it's still similar.

I tried to just define spidelay like follows:

> #define spidelay(nsecs)	ndelay(nsecs)

which basically works. But with that the maximum rate drops to 1.6MHz.
I assume that such a drastic performance decrease isn't acceptable for
the kernel?

Beneath that the bitrate isn't too well approximated. For a target
rate of 1MHz I get about 630kHz and for 100kHz I get 88kHz. But I'm
not sure how I could create something that has a good enough
estimation independent of the target architecture.

Any directions for how an acceptable implementation could look like?

Best regards

Christian Mauderer
