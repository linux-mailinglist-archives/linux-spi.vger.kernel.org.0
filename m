Return-Path: <linux-spi+bounces-6328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39294A0B4B8
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 11:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476DD164D25
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FB9235BE4;
	Mon, 13 Jan 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Va8eo152"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572E235C02
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764931; cv=none; b=gaavyV4KS6Dlx2G4H22MJiOHSvmFclBf8KKmBU8IYgNzNNwmBtQn5e7AkBNXCbcVbCc3/9uxbPdUcMtJnW/DcDeQUXDm0NnxKqSbDSBPKFgZOq7Z/z73r9LGn57cRc9KeYn6HrqHXKRrZE6zx1+bRnYEJ6kAVWyHLHzJa2O/AM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764931; c=relaxed/simple;
	bh=FHd4ljmsqqDK5joz7cxkIfhOAlN9l1wlsCgxrLjBlnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+jxKv+FZebdI5nHdUzUuazvYsneKVVtQN19gdEj0qpiBsm7ttiCMgBNE+Qy6LrsqYh0Qk0Y2LT712dkO/ZBFWm+GtyofPzb22CgsJJKIOdvGhLoIoqgZBc8t5aQwU7JAv+7Tcjt8xN7YtFES6EuyIFD5PHlbJdrPvZ827215pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Va8eo152; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69C7CFF804;
	Mon, 13 Jan 2025 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736764926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9QKyH4d/Jn+vKrG6CeiAYt7cqcclnPKT7uSdoAS4ME8=;
	b=Va8eo152sGrCS0D7YE5YMeyjKIZR2BVTEEoWhRuO5XcuSCIbneD2d8EVbSY6WPW1/GpLEz
	92oln4AGdTxPItp259Ientgtd487ZxRzhg+8wk+eijJWvc8hjPtUlliS/UM64Cl7RUsXE7
	4vy2b5bh8MaYJbg4aSuoOECy75c6DJ2CzmJwGS6JyjRd52Bf9e/cBBR5hNOS/gyLJ+cxTV
	LZKaODGwheUtpXOTt7EpjmmwHbUX7x0CIUnRtpRyO7BrYqBiCcQ4cLCKBc0ezdo9T6Y9bS
	RAB5TfobTV0YZXVhDa1dM1UgND+RxHYkOmSsT3DCCEq2J0mpXGdVcGw49hPq1g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,  Mark Brown <broonie@kernel.org>,
  linux-spi@vger.kernel.org,  llvm@lists.linux.dev,
  patches@lists.linux.dev,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
In-Reply-To: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
	(Nathan Chancellor's message of "Sat, 11 Jan 2025 12:08:38 -0700")
References: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 13 Jan 2025 11:42:06 +0100
Message-ID: <87h6630zcx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 11/01/2025 at 12:08:38 -07, Nathan Chancellor <nathan@kernel.org> wrote:

> After commit e6204f39fe3a ("spi: amd: Drop redundant check"), clang warns (or
> errors with CONFIG_WERROR=y):
>
>   drivers/spi/spi-amd.c:695:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>     695 |         return ret;
>         |                ^~~
>   drivers/spi/spi-amd.c:673:9: note: initialize the variable 'ret' to silence this warning
>     673 |         int ret;
>         |                ^
>         |                 = 0
>   1 error generated.
>
> ret is no longer set on anything other than the default switch path.
> Replace ret with a direct return of 0 at the end of the function and
> -EOPNOTSUPP in the default case to resolve the warning.

Correct, thanks.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


