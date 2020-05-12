Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA21CFDB0
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgELSrZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 14:47:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55178 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgELSrZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 14:47:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CIl0aH042905;
        Tue, 12 May 2020 13:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589309220;
        bh=gdpZbVGnmu82Ltylj7zMGAjghfqs8C0XbDqrJcvjIUw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GTrAAg1hJh7itOcW4SLu7lNpvXjddphXZysRjzEGFdlWjJXVRzwSncAD1hGESqoOq
         Yqx1WqS6Om6TRq4h94nigWX4VYc7/sUadEfEmgQ1OEUYxPV/nkFZurLYx+A6PIN0DO
         aB9Jjte/G2GkHBhyp1KqKrwyEGu8J6jJxMvMBxdg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CIl0WC011391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 13:47:00 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 13:47:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 13:47:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CIkxg4112061;
        Tue, 12 May 2020 13:46:59 -0500
Date:   Wed, 13 May 2020 00:16:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <linux-mtd@lists.infradead.org>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <alexandre.belloni@bootlin.com>,
        <richard@nod.at>, <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <miquel.raynal@bootlin.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Message-ID: <20200512184656.ksudjyeqbwv6jze6@ti.com>
References: <20200424184410.8578-1-p.yadav@ti.com>
 <144878625.o7txgtY6sz@192.168.0.120>
 <49abc8f3-5bb5-bc6d-b2ec-f14b115c58dc@ti.com>
 <2352513.UHBGRE98Z5@192.168.0.120>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2352513.UHBGRE98Z5@192.168.0.120>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/05/20 11:29AM, Tudor.Ambarus@microchip.com wrote:
> Hi, Vignesh,
> 
> > > The software reset procedure can't protect you from unexpected 
> > > resets, but
> > > the hardware with its optional reset pin can. Pratyush to confirm.
> > > 
> > > cut
> > > 
> > >>> Not recovering from unexpected resets is unacceptable. One should always
> > >>> prefer option 1/ and condition the entering in 2-2-2, 4-4-4 and 8-8-8
> > >>> with
> > >>> the presence of the optional RESET pin.
> > >> 
> > >> Totally agree with you on that one, but we know what happens in
> > >> practice...
> > > 
> > > What I proposed is to condition the entering in the state-full modes with
> > > the presence of the optional RESET pin. We would introduce an optional
> > > device tree property for the RESET pin. If hardware doesn't implement the
> > > optional RESET# signal, then we will not enter in the state-full modes.
> > 
> > Are you asking for dedicated SW controllable reset line or just an
> > indication from DT that OSPI reset line is connected to board level
> > soft/hard reset lines?
> 
> I don't see a need for the reset line to be SW controllable, a simple 
> indication from the device tree should be enough.

We already have the property "broken-flash-reset". Should we re-use it 
or should we have a opt-in property instead of an opt-out one?
 
> > 
> > Mandating SW controllable RESET line is bit of a stretch IMO... Board
> > design may not allow wasting dedicated pin due to lack of GPIOs perhaps..
> > 
> > For eg.: TI EVM has OSPI reset line connected to board level reset out.
> > This ensures any soft/warm/hard CPU reset will trigger OSPI Flash reset,
> > but there is no SW control that allows OSPI flash alone to be reset.
> > Isn't such a reset mechanism sufficient?
> > 
> 
> I think it is, yes.

-- 
Regards,
Pratyush Yadav
Texas Instruments India
