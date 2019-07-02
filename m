Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5135A5D0F5
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfGBNsr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 09:48:47 -0400
Received: from server101.serverconfig.center ([195.242.103.101]:48883 "EHLO
        server101.serverconfig.center" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbfGBNsr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 09:48:47 -0400
Received: from [192.168.96.177] (unknown [82.100.198.138])
        by server101.serverconfig.center (Postfix) with ESMTPSA id 188E6238098F;
        Tue,  2 Jul 2019 15:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-mauderer.de;
        s=default; t=1562075325;
        bh=g3P83tARUOybsH39N/CDp9dHtCGe/t7Nn69vLI1qdgk=; l=1250;
        h=Subject:To:From;
        b=f9h4lWHwTpaRFCtkgVrcooUrBlX8rsTDqjVICm0dVAoAR1TfK3Facaq1dP9ifD2qE
         GeSL/imbn/3vtGxoO7QOALznajfMb263WYN2obW0Q1mVkJIYDq7DYWXsCqC1i6Hx6P
         mFL8/fwBrU9Qbh5EMfge6idqImhmzBn9JD4SO/Uk=
Authentication-Results: server101.serverconfig.center;
        spf=pass (sender IP is 82.100.198.138) smtp.mailfrom=oss@c-mauderer.de smtp.helo=[192.168.96.177]
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
 <46a067d5-5c87-545b-d034-1cfbc7c674dd@c-mauderer.de>
 <20190702130008.GM2793@sirena.org.uk>
From:   Christian Mauderer <oss@c-mauderer.de>
Message-ID: <56b5135b-2897-6bee-8583-827716f322a5@c-mauderer.de>
Date:   Tue, 2 Jul 2019 15:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702130008.GM2793@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <156207532527.77586.17005822618139327017@server101.serverconfig.center>
X-PPP-Vhost: c-mauderer.de
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 02/07/2019 15:00, Mark Brown wrote:
> On Mon, Jul 01, 2019 at 08:33:27PM +0200, Christian Mauderer wrote:
>> On 01/07/2019 19:26, Mark Brown wrote:
> 
>>> I was actually thinking of a DT property but yes that too, probably
>>> would be useful for people trying to figure out the right number.
> 
>> My experience with the device tree from last time (a LED driver) was
>> that implementation specific properties are not that popular. A property
> 
> No, they're absolutely fine when they have a use case.
> 
>> that tells one special driver from which speed on it should just ignore
>> the speed and try it's best to do max speed seems quite implementation
>> specific. Maybe except if I try to introduce a max-speed property to the
>> SPI slaves that can be used instead of the speed.
> 
> You can already set the maximum speed - this is about tuning a
> very system specific point to switch implementations.
> 

Sorry, bad choice of words. I meant that I could try to introduce a
value for the maximum speed setting to just use the best that is
possible. Something like

    spi-max-frequency = "AS_FAST_AS_POSSIBLE"

But I think I'll just start with the implementation and discuss that as
soon as I have a working prototype.
