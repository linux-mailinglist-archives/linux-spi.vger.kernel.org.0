Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F714A4BD8
	for <lists+linux-spi@lfdr.de>; Mon, 31 Jan 2022 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380291AbiAaQWn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Jan 2022 11:22:43 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53303 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380274AbiAaQWn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Jan 2022 11:22:43 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 930C320000D;
        Mon, 31 Jan 2022 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643646162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UewgNsUTa79blJ++wbDOmKq0qNSUJEnPr+Q2Dtcr9gM=;
        b=o4/PkSK8xlwr9ppeXgaWVwd1Xx4euBvPJGk8dy2OrlN9e6w9U3UfHDXKnRD6WmALsASMpx
        TFPjLJfddfCWSNsgZUbS/MmzEqJOYLRcIUoPifpN6Lwpnn1urTlB+cyy+VWPYEWauLwPqi
        SapXGvkhEsSs259pS6/M1P7wlpoSHdO1aVJgZ0bOPKbnl+WxMqrIe5uw6BrbK1olgiepY9
        VJRpaHBJpJuUwxmEEOduP9jsQDTlouDopc/D1mXsOmeez8FvjiMOZUR7WasasLxt7HYfiS
        jN4/4Svlg3GjY8FR1fNxrU3D3uwHR1aEp2MAL+21fKrAMuJUjoWvWHrISOjnVg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH v10 03/13] spi: cadence-quadspi: Provide a capability structure
Date:   Mon, 31 Jan 2022 17:22:40 +0100
Message-Id: <20220131162240.24235-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-4-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd841578469634013248cc793a3d041342778d07e'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2022-01-27 at 09:17:58 UTC, Miquel Raynal wrote:
> This controller has DTR support, so advertize it with a capability now
> that the spi-controller structure contains this new field. This will
> later be used by the core to discriminate whether an operation is
> supported or not, in a more generic way than having different helpers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-4-miquel.raynal@bootlin.com

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-mem-ecc.

Miquel
