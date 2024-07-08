Return-Path: <linux-spi+bounces-3783-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23092A48A
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2F81C20F92
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918BD78C75;
	Mon,  8 Jul 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc8x61nB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFD1D54A;
	Mon,  8 Jul 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448706; cv=none; b=LlfbiW+S9guMS9pjXdL0e2YvlZtlySHhv3iPP4ZW/Fp1M4oCmFK84Un8YUtCjlocc8eNCxv4fN7Sreoch/gOoOk4QYOiBkFHYJkfCurNhjS1kbtnIuA5CqlsnqK7sWLA8GvFrTYgpLqdpIUDGKmzFcphn2warSCz9KngW9KDu1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448706; c=relaxed/simple;
	bh=g1CpAuGWx1fc7dYQtZoF14WXwCvADVuTmgpQldzlhxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZWC6GOB0K1mPBPYujqTc9d8TOThm9IWUpKmA0VUC8IQ6I5w2mPEmoRUptE0yFnhb55704ITBDwKJgH84MBe3B+TMUWwHGbhVkLYXMYrQ4r9J/+X4FW7scIZ052C6b+I+XIEuYE96ucnqg654F34fApioSHnNuyBvJ27WATIhEgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc8x61nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5299BC116B1;
	Mon,  8 Jul 2024 14:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720448706;
	bh=g1CpAuGWx1fc7dYQtZoF14WXwCvADVuTmgpQldzlhxQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oc8x61nBRacHU7tZPmfrodEg97/w5yPdVDJVmysM5NQN9YzG+RbKwIMeljWmw/EVQ
	 F3oVPcjCXdQ+oi+qfTqallNXiANQ9drHUtlKZb6H08/2l6wpa8EC+nqCluViUbmfjT
	 HVQ/fVgevyv7vvtNSgwArZAz65CbqQN/ExZV15gYQZHiZgPB4S6olVrAaqHRFTA50S
	 FNrv9ePw45doDQAxRwUeeW5oKWqQgv3UptW9N6dVYe399xalX00P6kTlAgDOZaZEKx
	 e5jW5QkXEj3UHPrVdgVdclq1t9CAGMFjSchZ5bV4bPweAB+GJiFDEBIoDQ7l8W5E+R
	 tubYpGgLSDNlg==
From: Mark Brown <broonie@kernel.org>
To: Li zeming <zeming@nfschina.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240708035320.14241-1-zeming@nfschina.com>
References: <20240708035320.14241-1-zeming@nfschina.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_spi=3A_spi=3A_Remove_unnecessary_=E2?=
 =?utf-8?q?=80=980=E2=80=99_values_from_rc?=
Message-Id: <172044870504.62411.6973199997525591445.b4-ty@kernel.org>
Date: Mon, 08 Jul 2024 15:25:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 08 Jul 2024 11:53:20 +0800, Li zeming wrote:
> rc is assigned first, so it does not need to initialize the assignment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi: Remove unnecessary ‘0’ values from rc
      commit: 0f2ecc3f6136a922f9d54499c80004bae6c42348

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


