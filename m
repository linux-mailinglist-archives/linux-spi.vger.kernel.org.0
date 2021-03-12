Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D943389E6
	for <lists+linux-spi@lfdr.de>; Fri, 12 Mar 2021 11:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhCLKUe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Mar 2021 05:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhCLKUR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Mar 2021 05:20:17 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B7BC061574;
        Fri, 12 Mar 2021 02:20:17 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4848322235;
        Fri, 12 Mar 2021 11:20:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615544415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AwJyDsly/A7V+5RW+umEy+/kfZBbndM17q5qch0pqs=;
        b=EC0cBBXxN04ASMeKveVSaUo+vYHbtl7LcZarVqKmw9+bat/GbF2Epq/Y9JOx5BwD1X4Tbv
        7ViqqBwt3I0tPDVP6DT7D1wrmEoYlT/xT+EiwfRmMmjKFeaympr/GTTRbaHbDfGLxBPU6l
        WBe87kMZ92vdrhYhqQJIfhbqXkY3n5U=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 12 Mar 2021 11:20:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor.Ambarus@microchip.com, nm@ti.com, kristo@kernel.org,
        robh+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, lokeshvutla@ti.com
Subject: Re: [RFC PATCH 0/6] spi: Add OSPI PHY calibration support for
 spi-cadence-quadspi
In-Reply-To: <20210312101036.jfz2733ssv4nhfey@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <9c551f56-4c00-b41a-f051-8b7e197fbcdc@microchip.com>
 <20210312101036.jfz2733ssv4nhfey@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <676386736df5e5b22e34b0b5af91c894@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-12 11:10, schrieb Pratyush Yadav:
> There is usually a delay from when the flash drives the data line (IOW,
> puts a data bit on it) and when the signal reaches the controller. This
> delay can vary by the flash, board, silicon characteristics,
> temperature, etc.

Temperature might change over time, but the calibration is only done
once. I don't know how much influence the temperature actually has, but
our boards are usually operating from -40°C to +85°C. So there might be
a possible temperature difference of 125K between actual calibration and
when the flash is accessed.

-michael
