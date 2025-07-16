Return-Path: <linux-spi+bounces-9112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E14B079FA
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC387B70E0
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11A2356BD;
	Wed, 16 Jul 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOeOZ/vO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0622A1E6;
	Wed, 16 Jul 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680118; cv=none; b=J9N1QO3V5O56O4DfCOrs3enmb2yMDoA+Dtn1g3/FBtJvHQ+Ex0S0rf2NzDxN2zIVksTkY9BmDO3iGb9Hqv+pFqdbDoB+h+0rzuoanbNFvuQl/L11Jgo8YRMw37X1UGVGlb53Z8pPqZ6XY/yw+E025B3/Vl1tE33ZehdzAFsDEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680118; c=relaxed/simple;
	bh=4q9OzSAo5rNNcKLV+kz4w4oQpdNs//RHhPGE3tlPVhE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j3WlH2+q6co7IVh1IQDcqjbri4ayrmc9ZswuFDCrR28YLaDXSUBFMa0CB2c4cdqBL0UwKIe2dR5H8l2Mxrci+YRV7NL1eyKwEh1gRzliiIZl4ElgenyXq49a2filuw4NOmDWdouakWHzdIeagbWIrZXN89d27meH3rjXYoxt6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOeOZ/vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56C4C4CEE7;
	Wed, 16 Jul 2025 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752680116;
	bh=4q9OzSAo5rNNcKLV+kz4w4oQpdNs//RHhPGE3tlPVhE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=YOeOZ/vOzIokCOzvw+aEWGYwQB41qgFQw3bwrwdzUvMz6IroSZptWe6IpofGVgfjc
	 goZ2w5rwn+tWfLZ2q6+RJSNbBs6X4ZIrj7t1QNuOtOltdoAHPqyqWHil3OGoAsSdvX
	 pU9+6J0VXNrFfanFM9DbgJNOB0X86oLFqUWjWIbvv8RlR+VRekiH36EXjcg/j06jAE
	 DkUCcH4osFqVTwsP4gT3xTOgWxWb/koDQKDz/ZRTsSbmHQd+ct95jjHPLyRWYvVW2/
	 PlnRfEPwNeJ3gFWdpC1DZR5txMJmgkPtdUE8exc3XhOd/OlXDo/eEQiuuA6TaAVjd/
	 8T1oOEQbnopyg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Darshan Rathod <darshanrathod475@gmail.com>
In-Reply-To: <20250716095906.21812-1-darshanrathod475@gmail.com>
References: <20250716095906.21812-1-darshanrathod475@gmail.com>
Subject: Re: [PATCH] spi: gpio: Use explicit 'unsigned int' for parameter
 types
Message-Id: <175268011566.721108.5592985482306665761.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 16:35:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 16 Jul 2025 09:59:05 +0000, Darshan Rathod wrote:
> The C standard allows 'unsigned' as a shorthand for 'unsigned int'.
> For improved code clarity and consistency with the prevailing kernel coding
> style, replace the shorthand with the more explicit 'unsigned int' type
> for function parameters.
> 
> This is a purely stylistic cleanup and has no functional impact on the
> generated code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: gpio: Use explicit 'unsigned int' for parameter types
      commit: d929cc75e9791def049a90998aaab8934196131c

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


