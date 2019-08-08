Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0307865D0
	for <lists+linux-spi@lfdr.de>; Thu,  8 Aug 2019 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbfHHPch (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Aug 2019 11:32:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40508 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHPch (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 8 Aug 2019 11:32:37 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D319028CAE4;
        Thu,  8 Aug 2019 16:32:35 +0100 (BST)
Date:   Thu, 8 Aug 2019 17:32:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vigneshr@ti.com, bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Message-ID: <20190808173232.4d79d698@collabora.com>
In-Reply-To: <20190808131448.349161-3-tmaimon77@gmail.com>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
        <20190808131448.349161-3-tmaimon77@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu,  8 Aug 2019 16:14:48 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:


> +
> +static const struct spi_controller_mem_ops npcm_fiu_mem_ops = {
> +	.exec_op = npcm_fiu_exec_op,

No npcm_supports_op()? That's suspicious, especially after looking at
the npcm_fiu_exec_op() (and the functions called from there) where the
requested ->buswidth seems to be completely ignored...

> +	.dirmap_create = npcm_fiu_dirmap_create,
> +	.dirmap_read = npcm_fiu_direct_read,
> +	.dirmap_write = npcm_fiu_direct_write,
> +};
> +
