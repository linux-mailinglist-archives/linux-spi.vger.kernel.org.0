Return-Path: <linux-spi+bounces-262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59828811983
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F203D1F2166F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 16:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD32A1BA;
	Wed, 13 Dec 2023 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPC/l228"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6585360;
	Wed, 13 Dec 2023 16:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0555C433C8;
	Wed, 13 Dec 2023 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485131;
	bh=odZ1MQY6e5KqzUlrj24nd/XYhqc7X1mQzuFErG0nj6I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TPC/l228szv0HrOVhUFnCl2ggjMKWRJ61PGzfrZp15kcPatwJNxZt+HGvsOaXgy/B
	 dVLozXjJqtllvypDcwe7VH4RD1jRy5pUmx13SQKoFF982iH1QoEiFGPLTZLZYY6Bfx
	 JLJZP6J/g5ozaYfjWpwyh1CGy17NXTKSBhsc/x5Onxhc7ZCw2jUsVL/Z69Tv6XoslH
	 YBAYzCNM3Gwflm7a3x9Vuzty1or2Uvz0s6RTV5/N3q1Usyn7Seb6ixd67aTuPttW4O
	 bfYBhibwIUs1iuv2bctj9Hz5Fy2MsIQJzXVjW5AOSp7c83n5uHeYi2YVCzZZJbjL8L
	 32POkNGB11Nqw==
From: Mark Brown <broonie@kernel.org>
To: fancer.lancer@gmail.com, robh+dt@kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nandhini.srikandan@intel.com
Cc: devicetree@vger.kernel.org, mgross@linux.intel.com, kris.pan@intel.com, 
 kenchappa.demakkanavar@intel.com, furong.zhou@intel.com, 
 mallikarjunappa.sangannavar@intel.com, mahesh.r.vaidya@intel.com
In-Reply-To: <20231213060836.29203-1-nandhini.srikandan@intel.com>
References: <20231213060836.29203-1-nandhini.srikandan@intel.com>
Subject: Re: [PATCH v1 0/2] Remove Intel Thunder Bay SOC support
Message-Id: <170248512843.27334.1958241029702729417.b4-ty@kernel.org>
Date: Wed, 13 Dec 2023 16:32:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 13 Dec 2023 14:08:34 +0800, nandhini.srikandan@intel.com wrote:
> This patch set removes Intel Thunder Bay specific code as the product
> got cancelled and there are no end customers.
> 
> Patch 1: Remove Intel Thunder Bay spi dw binding specific code.
> Patch 2: Remove Intel Thunder Bay spi dw binding Documentation.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dw: Remove Intel Thunder Bay SOC support
      commit: e1fca6957f1966cb6e75cdc354f4bcaed230a454
[2/2] spi: dw: Remove Intel Thunder Bay SOC support
      commit: e1fca6957f1966cb6e75cdc354f4bcaed230a454

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


