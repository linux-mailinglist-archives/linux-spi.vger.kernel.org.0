Return-Path: <linux-spi+bounces-4200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC2952F7E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 15:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64601C243FB
	for <lists+linux-spi@lfdr.de>; Thu, 15 Aug 2024 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEB41A706B;
	Thu, 15 Aug 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvw8HT2N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F581A7065;
	Thu, 15 Aug 2024 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728773; cv=none; b=LpzJASqhY302Mh5IjqSZaLvuN+qZb3efNVA7wvw4xLDnviJG2u2dgysI46qMwQqoV89aGNwWByF8nS/dbpefX+UlvtIDQWaOnOllTTaMjwejc966J7+PF4oBaU6wp8vMVlErYS/AbP/KMa+xeb/vTG6EBNrUT6/ksqLH8tmy9iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728773; c=relaxed/simple;
	bh=Vn19Xi4ZD3NibAsDtE9rg4C23yKZi6DinH/0puuPjiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qC5AScE8Z7xgA65CPW4JS6bJYpkoWD5G758CF1VRICXrXARFZ/W4Cge3T3E7yfOmDwAPnN8aQ4mLv67vXkr+BDiIFDB94IkzrmbgeszRc9BQWtZT4rhepwL/2LYZ/WoZPOsowQS5dZpIRFPJJR9kK+6qur023Jbzp2JJviIeHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvw8HT2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB093C4AF11;
	Thu, 15 Aug 2024 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723728773;
	bh=Vn19Xi4ZD3NibAsDtE9rg4C23yKZi6DinH/0puuPjiA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lvw8HT2NiRmF/9qLSb/v75tDmc9iRDV67VElI97FrWggnzcp2zYml/2GCs3wFknZ7
	 KH8BxUIT+Txe7GuoY4T6O3TrHZ8agza5tbhpBByzLod++O4ysxoXMj4FtqbcyQrshi
	 fdS1o6Q5sFcOhKT87PMSngRf70vORZMO9ETLh0tLnsCi3dU19mv/Fv39/R9rax0Tni
	 0cJ9qvwTMeGMbrQkFNQeX9AcBwcxXl8RPamqbjFjJNAvUTOjS8x6P9iB5xRVB/y+2F
	 XEaHwLLFaUfnyucRwh5gDibz9yYuc4n4vy7t3CIW0X5PmhX+eOJwxe7VnSHc/PtlgU
	 KeU4fuZFTDJdA==
From: Mark Brown <broonie@kernel.org>
To: jwboyer@linux.vnet.ibm.com, dbrownell@users.sourceforge.net, 
 sfalco@harris.com, akpm@linux-foundation.org, sr@denx.de, 
 Ma Ke <make24@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240722141822.1052370-1-make24@iscas.ac.cn>
References: <20240722141822.1052370-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] spi: ppc4xx: handle irq_of_parse_and_map() errors
Message-Id: <172372877149.37632.11411791571570145777.b4-ty@kernel.org>
Date: Thu, 15 Aug 2024 14:32:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 22 Jul 2024 22:18:22 +0800, Ma Ke wrote:
> Zero and negative number is not a valid IRQ for in-kernel code and the
> irq_of_parse_and_map() function returns zero on error.  So this check for
> valid IRQs should only accept values > 0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: handle irq_of_parse_and_map() errors
      commit: f1011ba20b83da3ee70dcb4a6d9d282a718916fa

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


