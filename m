Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D54A489D
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiAaNt0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 08:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379138AbiAaNtY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 08:49:24 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE60C061714
        for <linux-spi@vger.kernel.org>; Mon, 31 Jan 2022 05:49:23 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 28FF5FF80F;
        Mon, 31 Jan 2022 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643636962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i0ebk4yhbArcz3JBloFwALfFKX+cehM0zWe+fzdaqA=;
        b=P/8UCFDpXfQuQbnEIXdtMWcCpevXiyQ5YIBjaE/H0dHp69zfQSefMSzvoN6qOGuilAIEiP
        cZ9wGzbT/PsReS4Z+rJgADtosmy/PgVvH1wV3EbLRixPwdSjZKL7DVRLV+dIJapaclIzAm
        VIzSXH2WTy3QodtKVPp6U9ifhbb97EM069GRXkUI95O1kDGoRVW6E4xX5Mto1R84qWh/om
        5Kr8dH62lUtxUSS4DRJ8nIE3c0o5JHt841DWVU62gZsg0ZeChRo+ueVxJFEKmSMARNU3kz
        KZpXgFfVgAj3nCPiAgXtuBv9r1hk1ub8v12XswtdkW0MJejwXhwg+NlrX7hj+Q==
Date:   Mon, 31 Jan 2022 14:49:17 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 00/13] External ECC engines & Macronix support
Message-ID: <20220131144917.63c36b92@xps13>
In-Reply-To: <YfRvjJf+6Db89RRg@sirena.org.uk>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
        <YfL5ApsG7c619+R0@sirena.org.uk>
        <20220128090812.5b7a5982@xps13>
        <YfRvjJf+6Db89RRg@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Fri, 28 Jan 2022 22:34:52 +0000:

> On Fri, Jan 28, 2022 at 09:08:12AM +0100, Miquel Raynal wrote:
>=20
> > As three patches in this series were new/reworked I dropped your tag
> > there. I should have asked you again. Shall I add them (back) to the
> > following patches? =20
>=20
> > 	spi: cadence-quadspi: Provide a capability structure
> > 	spi: mxic: Provide a capability structure
> > 	spi: spi-mem: Introduce a capability structure =20
>=20
> Yes, please.

Great, thanks. I'll apply v10 soon, and will share an immutable tag.

Thanks,
Miqu=C3=A8l
