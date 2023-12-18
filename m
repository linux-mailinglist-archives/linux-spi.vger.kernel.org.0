Return-Path: <linux-spi+bounces-325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C49817A94
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E69B283709
	for <lists+linux-spi@lfdr.de>; Mon, 18 Dec 2023 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA1F495DE;
	Mon, 18 Dec 2023 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wo5kaf4w"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD022091;
	Mon, 18 Dec 2023 19:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF37C433C7;
	Mon, 18 Dec 2023 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702926373;
	bh=DPDqKYmI8qgbkxQDO8uN7PM5IVz1b5OEtAbJMsgDAko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Wo5kaf4wcUGWaFoMvf+D6sRS7zk0+YQkNV3YidGrEyKIaTO2Z9opFRC2r8XmQ6UID
	 FrxLIZSYIlmnkmEl1y/8tcHmpvNBQdJhtBESstHf5kQhuimRhILZLM2gnZdUdnZu0f
	 iFgPcPddFvHsoTXDAl44dtPVtkYsgvBHWdeI/FNwuQHUvUoTnCCXkX2fZLOoeY3XEO
	 md+aPj243OfuArhgSYtwCUtUFvSizQqDiBu7gVBXsdZ6fbXhHGJ1wqtiJFB7V57KKe
	 I55w7pyLeWZDiN/qPhjI8GqfOBUeBVpIy7O9sNgby5r9on/P8PgYkS+S1DZK7W2sRC
	 ldk85ZQoLPLyg==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20231218145348.339470-1-dlechner@baylibre.com>
References: <20231218145348.339470-1-dlechner@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: fix struct member doc warnings
Message-Id: <170292637153.111730.7490905316455174220.b4-ty@kernel.org>
Date: Mon, 18 Dec 2023 19:06:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Mon, 18 Dec 2023 08:53:45 -0600, David Lechner wrote:
> The build bots are complaining that the members of struct
> spi_engine_message_state are not described. This adds the
> proper @name: syntax to the comments to fix this.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: fix struct member doc warnings
      commit: 15009a1b145b033c39a6b65d529c83de71a8d732

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


