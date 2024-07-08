Return-Path: <linux-spi+bounces-3784-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4392A48C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509F2281B3C
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D205F13D29A;
	Mon,  8 Jul 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0/dy2Bj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1513CFBD;
	Mon,  8 Jul 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448707; cv=none; b=ptjyGNuOYFQErRO0II+gFsax+/v9tUmy8G2F5yjc7Gd/pNdOFSW9X6vLNs9ZAK5M195xBR+9LL4/oL73GHWnRcTVLIKAbQqWKYojTmmshkjrhnDLVGVpQ7PUsSvHcg176dkmn3kzUdPZwZiCW+nzHjPyaYUXATV2AtLwW62WpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448707; c=relaxed/simple;
	bh=K252BHbhCeYZsNU10lO+Yrma0vOmIUKDNaVsBba8AuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QA1G2VTIYacAjLoKwaqm6YzUpp1h+9J3lu05tPMYk2vu2BjMLOYTPmZddv8r3v/CIBS/AhLDI0h+BdtYr6i8HGdmHdtYs6Llr7O8DgrRYzKaPeyQDmEZY3lX6P1bzvtYrlZdw4LN2RU5LftrvJboNRasqbnpfeX+qRn159i+90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0/dy2Bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78167C32786;
	Mon,  8 Jul 2024 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448707;
	bh=K252BHbhCeYZsNU10lO+Yrma0vOmIUKDNaVsBba8AuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p0/dy2Bjw1H8Yw2OYU43qt0OVzQtXsRDVDKxa9WplbKWpG/7mIJzsdKyDw4yNqIxu
	 HF1i5HSxaKQHvVIaOHVDNOzY8ORv1D1feognJMcL2rTv67A9s6U32kT5nse5LZ51q7
	 xoNTln7dB2fY9HSJkDHw47xdRNO/axXOucnB8XS2NRVkND/OxRoy+11Uwa30Q4YqFi
	 NCTqOWj5+aGOChQ0XV6wOlIBahK6YiUG7c60PcS+IjJjIv7jEuq0QSI8iADZ/+jKuQ
	 sjeQBY3FmA/pzKZuJZ9QIyQmaFGG/yli5sumqU85yZhOqoX762ZC5wo6W57yB8x4sy
	 BXLEvCt6X8rcg==
From: Mark Brown <broonie@kernel.org>
To: Li zeming <zeming@nfschina.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240708041411.14424-1-zeming@nfschina.com>
References: <20240708041411.14424-1-zeming@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_spi=3A_spi=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_status?=
Message-Id: <172044870619.62411.15127828842067101415.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 15:25:06 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 08 Jul 2024 12:14:11 +0800, Li zeming wrote:
> status is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi: Remove unnecessary ‘0’ values from status
      commit: 3bca1a3808a9674c410dcae2ca07fb3fbd74e614

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


