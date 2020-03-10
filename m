Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8E1801AC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgCJPW2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 11:22:28 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46829 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJPW2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 11:22:28 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5324C23ECA;
        Tue, 10 Mar 2020 16:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583853746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdGYE+O0ALkRkOb+rA9Tz98qgHCKJH6tSFvrz+uxT1o=;
        b=DeiZr5VHKXR89WablI3UrMJKuQkPOBdGfFkzXtV9tbBQ/NoMoxhedHVvbVfcYEu4jv4AFo
        g4cA4bYD7TwwaWBH6f49Kl3dLswWVOOiwVrF15Nbwi5mZmag/iYXdrHjIMlgCfyjblInP3
        qBjFT8LgCcQwpHuCK1BMFJf/45sxsqs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Mar 2020 16:22:26 +0100
From:   Michael Walle <michael@walle.cc>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Esben Haabendal <eha@deif.com>,
        angelo@sysam.it, andrew.smirnov@gmail.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wei Chen <weic@nvidia.com>, Mohamed Hosny <mhosny@nvidia.com>,
        peng.ma@nxp.com
Subject: Re: [PATCH v3 0/7] NXP DSPI bugfixes and support for LS1028A
In-Reply-To: <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
References: <20200310125542.5939-1-olteanv@gmail.com>
 <615284875b709f602d57e4a4621a83c1@walle.cc>
 <CA+h21hrYoHVDvsxT1EPWhYprL+zNHfE4MW7k4HxiK7ma4ZWn1g@mail.gmail.com>
Message-ID: <59b07b7d70603c6b536a7354ed0ea8d8@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 5324C23ECA
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.399];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,deif.com,sysam.it,gmail.com,embeddedor.com,nvidia.com,nxp.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Vladimir,

Am 2020-03-10 15:56, schrieb Vladimir Oltean:
>> (2) Also, reading the flash, every second time there is (reproducibly)
>> an
>> IO error:
>> 
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> 01000000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> hexdump: /dev/mtd0: Input/output error
>> 00dc0000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> 01000000
>> # hexdump -C /dev/mtd0
>> 00000000  68 75 68 75 0a ff ff ff  ff ff ff ff ff ff ff ff
>> |huhu............|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
>> |................|
>> *
>> hexdump: /dev/mtd0: Input/output error
>> 00e6a000
>> 
> 
> Just to be clear, issue 2 is seen only after you abort another
> transaction, right?

No, just normal uninterrupted reading. Just tried it right after
reboot. Doesn't seem to be every second time though, just random
which makes me wonder if that is another problem now. Also the
last successful reading is random.

buildroot login: root
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
[   32.359156] random: crng init done
01000000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
01000000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00166000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00c68000
# hexdump -C /dev/mtd0
00000000  31 32 33 34 35 ff ff ff  ff ff ff ff ff ff ff ff  
|12345...........|
00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
|................|
*
hexdump: /dev/mtd0: Input/output error
00243000
#

-michael
