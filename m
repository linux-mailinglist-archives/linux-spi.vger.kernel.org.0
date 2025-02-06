Return-Path: <linux-spi+bounces-6644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37AA2ABA7
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66AF0188B0A5
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7244D1C7019;
	Thu,  6 Feb 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJepLqP/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B301A5B8C;
	Thu,  6 Feb 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852795; cv=none; b=HBOsDLhK/KjvOm9rrpdPP5Us9FuQw0mD4uhPkrRaiCY1GbEIG2IBr6YRjluj3/WZyAQeNLd1JOz+G0RDCAdiXE5lu97kamURleTlDcCoQgncLQK84BjyQ6ScWCtVCGY3MwZFJZxOy9aaIp3FXgn3A0VarfxyH1HThs8VwJdtuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852795; c=relaxed/simple;
	bh=nZz6okmmgJRHttY6GeW6J8e+lTfLet8Z+QhpBt4BmC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JQnShAmSEntE8j1+ECoVEcxIqMrGMjR6qDfLxu26FSlSWu2RKP6Y5L8b7jY9vd9rCZrlZ63c3atUYqV/KSYAccqfM9PzHROzi3l9W7JdMiGiYKXFnWLITRjdWXTuZiSfzwJQv0zCl7PhWyfReMbOQ2h4rIP0ps+mhgZkrhfqZQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJepLqP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47DCC4CEE2;
	Thu,  6 Feb 2025 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738852792;
	bh=nZz6okmmgJRHttY6GeW6J8e+lTfLet8Z+QhpBt4BmC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GJepLqP/Iy+xUz88cw4M+MHOhc7SOTm7xXNsj4NlnxwII7Wks7J7EC7StJ9IxuWyQ
	 yu7yko35qfVR0yvcvEdRPEVM74V5SpNlG+hEbyNo7VmxO7gynaKot4eSaMp/E4xd/x
	 HFXbOkMul2fPiAaYt/QpueZVUGzsxXx464czFuH0TFtobe2xQDImsAurGY3Br0Kvfy
	 pwlbvAr9up87e951ZOkstPgYHIrdc7lkuqboG92zTQ5ZQQA2Oe8Rs4hGQ7Mm6mwhPV
	 zEmxUGnTdGYotBhOh1OaDKmyQqDhTUUneXPaSVcBWYdu+bHcIPosl2B/zhHI/Gn9ao
	 bXfoNyes4ssIA==
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kohei Ito <ito.kohei@socionext.com>
In-Reply-To: <20250206085747.3834148-1-hayashi.kunihiko@socionext.com>
References: <20250206085747.3834148-1-hayashi.kunihiko@socionext.com>
Subject: Re: [RESEND PATCH v1] spi: sn-f-ospi: Fix division by zero
Message-Id: <173885279159.193118.16335534944708815878.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 14:39:51 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Feb 2025 17:57:47 +0900, Kunihiko Hayashi wrote:
> When there is no dummy cycle in the spi-nor commands, both dummy bus cycle
> bytes and width are zero. Because of the cpu's warning when divided by
> zero, the warning should be avoided. Return just zero to avoid such
> calculations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sn-f-ospi: Fix division by zero
      commit: 3588b1c0fde2f58d166e3f94a5a58d64b893526c

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


