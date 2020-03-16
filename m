Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A241870FC
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 18:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgCPRPv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 13:15:51 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45033 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbgCPRPv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 13:15:51 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 38F1323E61;
        Mon, 16 Mar 2020 18:15:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584378948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkBQjGfFX4RPCtdPTA+h09kDR0zYfg6Q74m+HlrgZjg=;
        b=BUT2OrTNA5Xq/cAeO91FOmT4Vzjbe6rHKp1In93/VKCG4yRRkIBEMx1g8VM3ucWOhC99tQ
        gXXjObJS/iVcITZh4uIi7mw2bxGCDz3580knWKtQ+9bQNN5z/dwyG9cvE46izCjWFCPPSu
        lOykjNLBPPfmahq+zd4DDQykcUgwifE=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 16 Mar 2020 18:15:48 +0100
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
Subject: Re: [PATCH v3 06/12] spi: spi-fsl-dspi: Replace interruptible wait
 queue with a simple completion
In-Reply-To: <CA+h21hqt7Xe1LrSDsCVS8zqunQp2tKGhmHDraMirxL595go4nA@mail.gmail.com>
References: <20200314224340.1544-1-olteanv@gmail.com>
 <20200314224340.1544-7-olteanv@gmail.com>
 <20200316122613.GE5010@sirena.org.uk>
 <CA+h21hqRV+HmAz4QGyH9ZtcFWzeCKczitcn+mfTdwAC7ZobdDw@mail.gmail.com>
 <20200316124945.GF5010@sirena.org.uk>
 <CA+h21hpoHGuDwpOqtWJFO7+0mQVUrmcBLW7nnGq6dt3QU5axfw@mail.gmail.com>
 <d05fda0e119405343e540b9768db534f@walle.cc>
 <CA+h21hqt7Xe1LrSDsCVS8zqunQp2tKGhmHDraMirxL595go4nA@mail.gmail.com>
Message-ID: <8c22cb70b7c0acb6769e0c68540ab523@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 38F1323E61
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         NEURAL_HAM(-0.00)[-0.660];
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

Am 2020-03-16 17:23, schrieb Vladimir Oltean:
> On Mon, 16 Mar 2020 at 15:25, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-03-16 14:00, schrieb Vladimir Oltean:
>> > On Mon, 16 Mar 2020 at 14:49, Mark Brown <broonie@kernel.org> wrote:
>> >>
>> >> On Mon, Mar 16, 2020 at 02:29:09PM +0200, Vladimir Oltean wrote:
>> >>
>> >> > Correct, the real problem is that I forgot to add a Fixes: tag for
>> >> > patch 5. I'll do that now.
>> >>
>> >> OK.  The series otherwise looked fine but I'll wait for testing.
>> >> Michael, if there's issues remaining it might be good to get some
>> >> Tested-bys for the patches prior to whatever's broken so we can get
>> >> those fixes in (but obviously verifying that is work so only if you
>> >> have time).
>> 
>> I'm just about to test it. While my former "cat /dev/mtdN > /dev/null"
>> is working. I had the impression that it was slower, so I tried to 
>> test
>> it with dd now and a known chunk size.. only to find out that it is
>> still not working:
>> 
>> # dmesg|grep spi
>> [    1.894891] spi-nor spi1.0: w25q128fw (16384 Kbytes)
>> ..
>> # time cat /dev/mtd0 > /dev/null
>> real    0m 30.73s
>> user    0m 0.00s
>> sys     0m 1.02s
>> # dd if=/dev/mtd0 of=/dev/null bs=64
>> 262144+0 records in
>> 262144+0 records out
>> # dd if=/dev/mtd0 of=/dev/null bs=64
>> 262144+0 records in
>> 262144+0 records out
>> # dd if=/dev/mtd0 of=/dev/null bs=64
>> dd: /dev/mtd0: Input/output error
> 
> I don't really have a SPI flash connected to DSPI on any LS1028A board.

I'm already debugging it again.

> Is this DMA or XSPI mode?

XSPI mode. DMA mode looked good for now.

>> 
>> I also wanted to test how it behaves if there are multiple processes
>> access the /dev/mtdN device. I haven't found the time to dig into
>> the call chain if see if there is any locking. Because what happens
>> if transfer_one_message() is called twice at the same time from two
>> different processes?
>> 
> 
> There is a mutex on the SPI bus, and therefore all variants of the
> .transfer() call are operating under this lock protection, which
> simplifies things quite a bit.

Ok, thanks.

-michael

>> >
>> > This time I verified with a protocol analyzer all transfer lengths
>> > from 1 all the way to 256, with this script:
>> >
>> > #!/bin/bash
>> >
>> > buf=''
>> >
>> > for i in $(seq 0 255); do
>> > »       buf="${buf}\x$(printf '%02x' ${i})"
>> > »       spidev_test --device /dev/spidev2.0 --bpw 8 --cpha --speed
>> > 5000000 -p "${buf}"
>> > done
>> >
>> > It looked fine as far as I could tell, and also the problems
>> > surrounding Ctrl-C are no longer present. Nonetheless it would be good
>> > if Michael could confirm, but I know that he's very busy too so it's
>> > understandable if he can no longer spend time on this.
>> 
>> I'm working on it ;)
>> 
>> -michael
> 
> Thanks,
> -Vladimir
