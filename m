Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568FD38B8BE
	for <lists+linux-spi@lfdr.de>; Thu, 20 May 2021 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhETVJb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 May 2021 17:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhETVJa (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 May 2021 17:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D96C611AD;
        Thu, 20 May 2021 21:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621544889;
        bh=EvVATraZB7E8n5NcWtsfxzj+03GDgZi3f8bDNL5+s5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7EfoLXIeE18DsIwSgllSOS+1jdt6RbObrpeTjyEtb+3ED5vDmn5R9T2zqU4Y/Nxf
         plG44LC0irFGKNauD1zUBCIVYzhxAjholcR3tN8q6aHTIsjBAoT6RbP+JdSbqqPAZz
         Re6jAt+he4SEEIPw/Y3ONN+1uyeTXsj93PQLzkczn53I1b7V4g+jf+woK3lm/Ltdu3
         4oJqoZd4UoiCoV5kmoJq0orJkLlnhEr7sjzQ1R6rHAr/cB7qViq0u4bP+PVTJihCqs
         sVzbcXAOg9WicQ+GOwKveiGG6kb5Vh8azu54zQF5reHtvFWvgKM4eQuM+snsMJkN2Y
         AWKiJvhmW3sNg==
From:   Mark Brown <broonie@kernel.org>
To:     Zhiqi Song <songzhiqi1@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 0/7] drivers: spi - add parenthesis for sizeof
Date:   Thu, 20 May 2021 22:07:59 +0100
Message-Id: <162154480154.5312.11734127389788487385.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
References: <1621301902-64158-1-git-send-email-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 May 2021 09:38:15 +0800, Zhiqi Song wrote:
> This patchset fixes missing parentheses of sizeof reported by checkpatch.pl
> under drivers/spi/.
> 
> Zhiqi Song (7):
>   spi: lm70llp: add parenthesis for sizeof
>   spi: mpc512x-psc: add parenthesis for sizeof
>   spi: mpc52xx: add parenthesis for sizeof
>   spi: mpc52xx-psc: add parenthesis for sizeof
>   spi: omap2-mcspi: add parenthesis for sizeof
>   spi: omap-uwire: add parenthesis for sizeof
>   spi: ppc4xx: add parenthesis for sizeof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: lm70llp: add parenthesis for sizeof
      commit: a2bd5afd59c1dec8e559096c3a5c912360c267ca
[2/7] spi: mpc512x-psc: add parenthesis for sizeof
      commit: 722cb2b197e125d6816aac43ec2d411c7b22daa9
[3/7] spi: mpc52xx: add parenthesis for sizeof
      commit: ac7357ac769e3b4bd52e691f22d745c89126069f
[4/7] spi: mpc52xx-psc: add parenthesis for sizeof
      commit: 75d4c2d64b30c8583b82afdcc9dc4db2083dee5b
[5/7] spi: omap2-mcspi: add parenthesis for sizeof
      commit: 8267dc6d6889235e6dac21156cc9d6e5d5319d3b
[6/7] spi: omap-uwire: add parenthesis for sizeof
      commit: 19bae51b0191129fd9a6d163678404b77cab24c9
[7/7] spi: ppc4xx: add parenthesis for sizeof
      commit: 07c74f844b740a858e40fe6c15dd9a2f3b7f6476

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
