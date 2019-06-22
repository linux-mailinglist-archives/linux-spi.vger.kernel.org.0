Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DEC4F3EF
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2019 07:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfFVFpy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 22 Jun 2019 01:45:54 -0400
Received: from server101.serverconfig.center ([195.242.103.101]:46077 "EHLO
        server101.serverconfig.center" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfFVFpy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 22 Jun 2019 01:45:54 -0400
Received: from christian-pc.localdomain (p2E5940A8.dip0.t-ipconnect.de [46.89.64.168])
        by server101.serverconfig.center (Postfix) with ESMTPSA id 8E7F1238274E;
        Sat, 22 Jun 2019 07:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-mauderer.de;
        s=default; t=1561182352;
        bh=0XCGZXsGhLFTHoofcoO3wIO4moEcXNx3QiWIK1Mi5LM=; l=1799;
        h=Subject:From:To;
        b=MQFyzBmgFUHM5lDEG6EyxOiX52P1ZIlXAyg+xWmfuhzOHZBFBU/kyUzOqJFnNmQpH
         jxvwrd1d9bHCQoiai2dvype/PUCKkrZBhUyHJDl3lMhiONXmN8d7/q1TzWxbHsEmEs
         w+885iVOgpHqrxmD9+q6Oous0l9/ui++scIf/poc=
Authentication-Results: server101.serverconfig.center;
        spf=pass (sender IP is 46.89.64.168) smtp.mailfrom=oss@c-mauderer.de smtp.helo=christian-pc.localdomain
Received-SPF: pass (server101.serverconfig.center: connection is authenticated)
Subject: Re: spi-gpio too fast for some devices
From:   Christian Mauderer <oss@c-mauderer.de>
To:     linux-spi@vger.kernel.org
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
Cc:     Mark Brown <broonie@kernel.org>
Message-ID: <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
Date:   Sat, 22 Jun 2019 07:45:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <156118235176.27196.14012556220849897597@server101.serverconfig.center>
X-PPP-Vhost: c-mauderer.de
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It seems that no one has read the mail that I've only sent to the list.
Mark Brown: You are the maintainer that would have to accept a patch in
that subsystem. Might I guide your attention to the mail?

Thanks

Christian Mauderer

On 10/06/2019 18:56, Christian Mauderer wrote:
> Hello,
> 
> I have a problem with the spi-gpio driver: It's too fast for one of my
> devices. Now I'm searching for a good solution that could be
> acceptable as a patch for the Linux kernel.
> 
> Currently there is the following comment and implementation for the
> spidelay(...) function in spi-gpio.c:
> 
>> /*
>>  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
>>  * requested device clock.  Software overhead means we usually have trouble
>>  * reaching even one Mbit/sec (except when we can inline bitops), so for now
>>  * we'll just assume we never need additional per-bit slowdowns.
>>  */
>> #define spidelay(nsecs)	do {} while (0)
> 
> With that I have a speed of about 2.2MHz on a QCA9533 chip with 650MHz
> using a 4.14 Kernel. The spidelay hasn't been changed in a newer
> kernel so I assume it's still similar.
> 
> I tried to just define spidelay like follows:
> 
>> #define spidelay(nsecs)	ndelay(nsecs)
> 
> which basically works. But with that the maximum rate drops to 1.6MHz.
> I assume that such a drastic performance decrease isn't acceptable for
> the kernel?
> 
> Beneath that the bitrate isn't too well approximated. For a target
> rate of 1MHz I get about 630kHz and for 100kHz I get 88kHz. But I'm
> not sure how I could create something that has a good enough
> estimation independent of the target architecture.
> 
> Any directions for how an acceptable implementation could look like?
> 
> Best regards
> 
> Christian Mauderer
> 
