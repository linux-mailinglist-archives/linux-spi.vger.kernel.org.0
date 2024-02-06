Return-Path: <linux-spi+bounces-1087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7ED84B4A3
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 13:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66D0B26877
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A11332BA;
	Tue,  6 Feb 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1zPfH9t"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA80133290
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221353; cv=none; b=qgOdD/ldsqj82UOqjfsab5BD+M+umemZrckObt3M/0v2dlvMw5nJMrOGaok2LyjexY8+6c1LbE28jjZi9upSHBQEcdw3p7XGAA6G6tFqsNCsjpkZIvAE3zOUzD5LTOHYBUJvM5Ne0HfS4QTMoEzJz0X0d54Y+2N3Nh0fJsY4SyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221353; c=relaxed/simple;
	bh=9A59fQRu8iFKJy4WXS1462kscu5WN4i82cS7Ys1v+L0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iMtmXwQ/AZWiYI9BmWG4WKJGoz+DkQIy55LYb/99T0vLzfgaxIRXbgxDILzquk+3WGWdHrmp+Ua4wl93FgTmifVV/nnsBxTJy+Q6MmkPK5fverMNyylDuw21eREMPbrycCiYNQZfEgkwKvuv3cQHjh8uwiKh6eWXobWPTpZgdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1zPfH9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA22C433C7;
	Tue,  6 Feb 2024 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221353;
	bh=9A59fQRu8iFKJy4WXS1462kscu5WN4i82cS7Ys1v+L0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u1zPfH9twmJDWGdaJhoamuDoXB9aGoiQk6U8p40pGf0aEhlpsgz+wXBtj/0d8KIzA
	 j2HItbMJNK65LvAng7e1gseihRSE3I7VGbhhiO3D5LA+QHV8yg72mJoVis9+7UNUAB
	 qq6JFUFrYXTZj+WUUs8fFlqGeC1M8eMYiiZgoCApDfSwbT+zsg7HL30dPHbTSqECpz
	 bjMbDJdZ4KyRrPMTfG9eDvyO4RoqzCkqzd07zRgvK4wuZm2q1wHft5IWeywDUhVl8h
	 fPkmt/VvykQP2c5r+/K53JiTqmYCMjydO1Tr5twG4WSj9aYRelD6p/gaOiFx7xVfIO
	 l/VifKTyA8L2A==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240201121638.207632-1-mika.westerberg@linux.intel.com>
References: <20240201121638.207632-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] spi: intel: Add default partition and name to the
 second chip
Message-Id: <170722135228.992289.12046879711882734427.b4-ty@kernel.org>
Date: Tue, 06 Feb 2024 12:09:12 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Thu, 01 Feb 2024 14:16:37 +0200, Mika Westerberg wrote:
> This should make it easier to identify the second chip and also allows
> using "mtdparts=" and the like with this chip too.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: intel: Add default partition and name to the second chip
      commit: e58db3bcd93b9e0bf5068a29f7e1a97c29926830
[2/2] spi: intel: Keep the BIOS partition inside the first chip
      commit: 83c9c7ec8b914faf91567132ab197c54253c277f

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


