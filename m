Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9850743491C
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhJTKmy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 06:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhJTKmy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Oct 2021 06:42:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9861E6128B;
        Wed, 20 Oct 2021 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634726440;
        bh=HTO3PFE7WKaMsIMWUS5h98d23XzhR3r2E6uEp1KEGzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xlx3I6cHEh7MzgwoJMxVvL9bpAByT+tlPakmcXlV5S5GHB5Imq48FpSXiSu/0DIVt
         QJLVk4tWCHWvFx5RUPBiyQnl2WdQR69nJdUVH8H5nxfKu5nWxQGxEGE291nTIKE1Py
         OSPsSP5uJh9uYbDcdneEhXtp9ppmfUBfVttmGuFhjLgmMi1ImJePJAPCYAeIu5czYw
         e+Km4xKDibSeN28CvdVeFARz+tj2bbtfoS3G7DQ3AuEltMsskmXe7ap6nwK9BtlTn+
         nMABh0Zql1iMf2FNN0j/GJRECZlTBKDX6HAXWX3OdjZDYRUhi7l9nUsSYfHJb4qYTU
         IrIkJTCh+hfeA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, yilun.xu@intel.com,
        hao.wu@intel.com, lgoncalv@redhat.com, trix@redhat.com,
        matthew.gerlach@intel.com
Subject: Re: [PATCH 1/1] spi: altera: Change to dynamic allocation of spi id
Date:   Wed, 20 Oct 2021 11:40:29 +0100
Message-Id: <163472624799.3119242.11242649254172689650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019002401.24041-1-russell.h.weight@intel.com>
References: <20211019002401.24041-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 18 Oct 2021 17:24:01 -0700, Russ Weight wrote:
> The spi-altera driver has two flavors: platform and dfl. I'm seeing
> a case where I have both device types in the same machine, and they
> are conflicting on the SPI ID:
> 
> ... kernel: couldn't get idr
> ... kernel: WARNING: CPU: 28 PID: 912 at drivers/spi/spi.c:2920 spi_register_controller.cold+0x84/0xc0a
> 
> [...]

Applied, thanks!

[1/1] spi: altera: Change to dynamic allocation of spi id
      commit: f09f6dfef8ce7b70a240cf83811e2b1909c3e47b

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
