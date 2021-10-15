Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3D42EC57
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhJOIbX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 15 Oct 2021 04:31:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43807 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbhJOIbX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Oct 2021 04:31:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id B9D6924000F;
        Fri, 15 Oct 2021 08:29:13 +0000 (UTC)
Date:   Fri, 15 Oct 2021 10:29:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     jaimeliao@mxic.com.tw
Cc:     "Boris Brezillon" <bbrezillon@kernel.org>,
        "Mark Brown" <broonie@kernel.org>, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        "Richard Weinberger" <richard@nod.at>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Tudor Ambarus" <Tudor.Ambarus@microchip.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Xiangsheng Hou" <Xiangsheng.Hou@mediatek.com>
Subject: Re: =?UTF-8?B?5Zue5L+hOg==?= [RFC PATCH 09/10] spi: mxic: Add
 support for direct mapping
Message-ID: <20211015102911.25732215@xps13>
In-Reply-To: <OF032BE161.2014BA23-ON4825876C.0027CC4D-4825876C.0027D1E7@mxic.com.tw>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
        <20211008162228.1753083-10-miquel.raynal@bootlin.com>
        <OF032BE161.2014BA23-ON4825876C.0027CC4D-4825876C.0027D1E7@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Jaime,

jaimeliao@mxic.com.tw wrote on Tue, 12 Oct 2021 15:14:56 +0800:

> Hi Miquel
> 
> ZhengxunLi have patch new mxic spi host controller before.
> The patch name as below
> spi: mxic: patch for octal DTR mode support
> Please patch mxic ECC engine base on latest version.

Yes you are right. I didn't rebase my series before sending it, as
mentioned in the cover letter this was just a way to provide this code
publicly as someone from Mediatek needed it (hence, the RFC). I will
soon send a real v1 with the bindings fixed as well.

Thanks,
Miquèl
