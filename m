Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4CD65C311
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jul 2019 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGASdb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jul 2019 14:33:31 -0400
Received: from server101.serverconfig.center ([195.242.103.101]:37785 "EHLO
        server101.serverconfig.center" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfGASdb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jul 2019 14:33:31 -0400
Received: from christian-pc.localdomain (p2E5940A8.dip0.t-ipconnect.de [46.89.64.168])
        by server101.serverconfig.center (Postfix) with ESMTPSA id B757E238327E;
        Mon,  1 Jul 2019 20:33:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-mauderer.de;
        s=default; t=1562006009;
        bh=H0Ux9aDAY2CvDDcv2o/37mw23NApec0UNHtwblmx93s=; l=853;
        h=Subject:To:From;
        b=gvDXlbD9uw/5XIO+WuWvPNIUeu+hh4YvYwibdWFtXoioMbcL4KMbFAh+ecGSAZ9VI
         YlQR2rSreC7nau/z1db6ccG9Y+u2q1zujTfCswj/YefIqqBP65e4HsXG2FjCpy4MWi
         zCv9T+s1VPvKvMQt9/wG7IxrAgVJ2XT5nJeIle7g=
Authentication-Results: server101.serverconfig.center;
        spf=pass (sender IP is 46.89.64.168) smtp.mailfrom=oss@c-mauderer.de smtp.helo=christian-pc.localdomain
Received-SPF: pass (server101.serverconfig.center: connection is authenticated)
Subject: Re: spi-gpio too fast for some devices
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>
References: <32d3f238-c21c-b937-72c9-7a9ba842c01e@c-mauderer.de>
 <a06e9923-735a-da2c-9946-4740842d5ca5@c-mauderer.de>
 <20190624132352.GL5316@sirena.org.uk>
 <7e9d963c-9402-979c-1dbd-51e548a15652@c-mauderer.de>
 <a1cb37c8-dc05-3827-0646-3bf58937a19b@c-mauderer.de>
 <CAMuHMdX7g0QePv4KustSExjyQOxHyATpShWEVBVyNXLvqon0Dw@mail.gmail.com>
 <20190701165930.GE2793@sirena.org.uk>
 <88b52423-7489-8958-ad87-5139a6213e4e@c-mauderer.de>
 <20190701172635.GF2793@sirena.org.uk>
From:   Christian Mauderer <oss@c-mauderer.de>
Message-ID: <46a067d5-5c87-545b-d034-1cfbc7c674dd@c-mauderer.de>
Date:   Mon, 1 Jul 2019 20:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701172635.GF2793@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <156200600900.125508.16197487008575473014@server101.serverconfig.center>
X-PPP-Vhost: c-mauderer.de
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/07/2019 19:26, Mark Brown wrote:
> On Mon, Jul 01, 2019 at 07:22:06PM +0200, Christian Mauderer wrote:
> 
>> Sorry that I'm not that common with the terms: With property you most
>> likely mean one changeable at run time via the /sys filesystem right?
> 
> I was actually thinking of a DT property but yes that too, probably
> would be useful for people trying to figure out the right number.
> 

My experience with the device tree from last time (a LED driver) was
that implementation specific properties are not that popular. A property
that tells one special driver from which speed on it should just ignore
the speed and try it's best to do max speed seems quite implementation
specific. Maybe except if I try to introduce a max-speed property to the
SPI slaves that can be used instead of the speed.

Best regards

Christian
