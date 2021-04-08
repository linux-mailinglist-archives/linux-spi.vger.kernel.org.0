Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F61358398
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 14:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhDHMsc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 08:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHMsb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Apr 2021 08:48:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C2C061760;
        Thu,  8 Apr 2021 05:48:20 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A213E22234;
        Thu,  8 Apr 2021 14:48:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617886097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yyglUwoXCuz0ysTDi3YJvq4eALpeWh9ZYLQqhbUo0lE=;
        b=eGMCh33PKQSr1IcC4SXPqEI87EmqQVMRbunXLG1RTcr9lRiR5UaXoGdiZKuegxfHu/1OCt
        JcX6cLF9kglN4YtT4ev96AzJ9Xdo6IpwuVpf5bCWaGk9jVYqLYi43qbI+LFUlpTWhUlITL
        HhV0t0QsGEoNoOGaWgBWjBZpm4FTYVU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Apr 2021 14:48:16 +0200
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
Subject: Re: [RFC PATCH 2/6] mtd: spi-nor: core: consolidate read op creation
In-Reply-To: <20210311191216.7363-3-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-3-p.yadav@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <22d1042e061e355b0ddd122ef1228535@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-03-11 20:12, schrieb Pratyush Yadav:
> Currently the spi_mem_op to read from the flash is used in two places:
> spi_nor_create_read_dirmap() and spi_nor_spimem_read_data(). In a later
> commit this number will increase to three. Instead of repeating the 
> same
> code thrice, add a function that returns a template of the read op. The
> callers can then fill in the details like address, data length, data
> buffer location.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

Reviewed-by: Michael Walle <michael@walle.cc>
