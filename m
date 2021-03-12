Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8A338ED9
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 14:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhCLNcu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 08:32:50 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53989 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhCLNc0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 08:32:26 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 438F722238;
        Fri, 12 Mar 2021 14:32:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615555945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBuZP8POWp3qMMHBSO5zfPwntXaxLE+5SncR7mrkwkQ=;
        b=fVeBkdcbfb0c7Z3025M6QUtKCnZBa2aNX05py5QmSYQTSEaWsyniqyN9M5FHUL77xqM7xq
        FzoedG7HmpzUT5MtJ1BsZSmiUozPbYcGeQxArBa9KJzjjwsUR1CRbDuLYSTz2W1mxDlWG3
        oNTTVz+JnDS/UK8Y6Ravou9ofFt/t6Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Mar 2021 14:32:25 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
In-Reply-To: <20210311191216.7363-1-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b9450a151cce89cde47b4d6a76c74b32@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> The main problem here is telling the controller where to find the
> pattern and how to read it. This RFC uses nvmem cells which point to a
> fixed partition containing the data to do the reads. It depends on [0]
> and [1].
> 
> The obvious problem with this is it won't work when the partitions are
> defined via command line. I don't see any good way to add nvmem cells 
> to
> command line partitions. I would like some help or ideas here. We don't
> necessarily have to use nvmem either. Any way that can cleanly and
> consistently let the controller find out where the pattern is stored is
> good.

The NXP LS1028A SoC has a similar calibration (although there its done
in hardware it seems) and there the datasheet mentions there are flash
devices which supports a preamble before a read function. The preamble
is then some kind of learning pattern. Did you see a flash which 
actually
supports that in the wild? I can't find any publicly available 
datasheets
of 8bit I/O SPI NOR flashes.

-michael
