Return-Path: <linux-spi+bounces-4439-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420A964CF6
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92A61F21B98
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F31B78E4;
	Thu, 29 Aug 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6bonTJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD21B6546;
	Thu, 29 Aug 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953127; cv=none; b=mcoRFQUv0O3QK+IgfBU17Tz3ynStwrE3gIaDV2NHM0hULMuCU6Q6h5cFcYbvdKiFG0oEBFFvB5ZZ2KHxqjWrmlsYhUo4LYCfu2ZJ76mifLyFwi6Vl5EqXAbAvOs71kJ7TKNFJuwzdCaCZfFFjiMJb5lbJn2xt8Ufqqpvs+WUGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953127; c=relaxed/simple;
	bh=aMlOb4pNYgyhx21tb5RrxMoj5116RIgx1YGUw9c22aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kzzTU9U+ftGVi36FLXN+DBzIIDF8yZdaMkan2QCXOg3fKW9y+dcRQ++GWMkasbUz1PVfjrOUEDzvX6UyLOuFIxN87fPQLFuP+oyGZxM9tYCHzEM8CsrUTB/oPqKw34zkxL89rDT87IeKAMrnO0KjVuC3Fb7mYm+MbkVmWs7+nKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6bonTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35CAC4CEC7;
	Thu, 29 Aug 2024 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953127;
	bh=aMlOb4pNYgyhx21tb5RrxMoj5116RIgx1YGUw9c22aA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ld6bonTJVeaDlfa76gVLsOXyqEbHWhkQXuWze08HLOUpHeXVdt/7E+a4qgMN8h/lP
	 q+cf2XZNbTN/tGRHRjFDs1NPouI/znr/E1wa9t9uF2q5RHyZuc36XeSsODPghjZv8f
	 M3ZodOB2WJoMcAwoRnF1Zvx2i6vVBp//NOaEDSw0De7j47K4Omd16clvbVqKXBvhPK
	 hwr0UKmgxPV8Y2Zt76acLHczbgKBIbzjyswXgDlqLoefouXmoeIUaQz1QJxcyDcLjL
	 Q1xvIeqEOmmkIlV/TmNWy1b53staXjVd8/J0z7Iy54Yra8UGtyU/xIGBNIE9GLYtrR
	 +DVdmYA4UaTeA==
From: Mark Brown <broonie@kernel.org>
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Ruibin <11162571@vivo.com>
Cc: opensource.kernel@vivo.com
In-Reply-To: <20240829033511.1917015-1-11162571@vivo.com>
References: <20240829033511.1917015-1-11162571@vivo.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing
 pci_dev_put()before return
Message-Id: <172495312546.812311.690393310730563993.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 18:38:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Thu, 29 Aug 2024 11:35:11 +0800, Yang Ruibin wrote:
> Increase the reference count by calling pci_get_slot(), and remember to
> decrement the reference count by calling pci_dev_put().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers: spi: Insert the missing pci_dev_put()before return
      commit: 8a0ec8c2d736961ff556e9d331decda9048fe0f1

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


