Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB0474812
	for <lists+linux-spi@lfdr.de>; Tue, 14 Dec 2021 17:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhLNQ3w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Dec 2021 11:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhLNQ3s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Dec 2021 11:29:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDFC06173F
        for <linux-spi@vger.kernel.org>; Tue, 14 Dec 2021 08:29:47 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4D4801F4510A;
        Tue, 14 Dec 2021 16:29:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639499385; bh=sD8RcvWISFDTFZlYrC8HhC7WB4mL2HFouLE2Z3Yab/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aiz6URABrHkAw/GeqTF1COX6XSS2TgOgn5h3zPsppV9/9iKxkCZvw/eEUq+ILOb7b
         +AoY9suC+GWRkS+ie9KYryWTyYTQ5rKEZuZqedun7larxuh8H0lSESMCBZs54rBCnL
         e+Eb7gjqCi/fOevVhW9gg/c5XOq5AaM4P4fCn58/0fUInrjdbB4/PVPAj1i6szqB6j
         7O0aYqY1MYH1qJxydwFnifiF3fGSqWObxEW1hh3IbtNbcYlL8WEmtbJ8A5HUd5fwiS
         jM8TUZY+u+SDPr1JUPUWc01Z/Bjqv7KkqrLGiRbQPMCtMFNDQ1lodM4baZKMimL1e4
         l/oqorpl4E3Vw==
Date:   Tue, 14 Dec 2021 17:29:42 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>
Subject: Re: [PATCH v5 06/13] spi: spi-mem: Add an ecc_en parameter to the
 spi_mem_op structure
Message-ID: <20211214172942.4647532f@collabora.com>
In-Reply-To: <20211214114140.54629-7-miquel.raynal@bootlin.com>
References: <20211214114140.54629-1-miquel.raynal@bootlin.com>
        <20211214114140.54629-7-miquel.raynal@bootlin.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 14 Dec 2021 12:41:33 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> +	if (!caps->ecc) {
> +		if (op->ecc_en)
> +			return false;
> +	}
> +

Nit:

	if (op->ecc_en && !caps->ecc)
		return false;
