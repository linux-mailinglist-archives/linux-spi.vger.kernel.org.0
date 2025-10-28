Return-Path: <linux-spi+bounces-10870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC77C14515
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C375E296C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 11:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6E307AFA;
	Tue, 28 Oct 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMkSgG2R"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB94304BD6;
	Tue, 28 Oct 2025 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650268; cv=none; b=AEkKj+G+uQJkEY7ugg9PIlAJGbu9LIN+jJH1SjTJVzXyZ9UhLyXTPjOTmxK7JeEtuLDnmQIIILly7NdrhjXmbKaJvtoyB6UMsGyVIv81Edo0ROUd1GawexlC9tPY65J4b/pMgnXvmZ1rP+CCR2nBH9Mxp48+S768OIRJojI/09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650268; c=relaxed/simple;
	bh=7/gLkLB9h8o5ZKJgKkpth0iLEEKFQq7O8xx3oW7AAXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TpLdWRra01Xh9rtkFS/H8Xrk1+aplqlu9Iy8kJmA0SCu7z9mr/hb8dP+DHnuWFsS5IwWuyb+M948x5bS4rPAgJg2efwSWtL/Jp8JFpLjVDf2SuhpK/JvvOy75V+xxUONqM3z2nPSD6QH6i0gnzpfY43ODpn+ie/BVykQbFmaTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMkSgG2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D9FC4CEF7;
	Tue, 28 Oct 2025 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761650266;
	bh=7/gLkLB9h8o5ZKJgKkpth0iLEEKFQq7O8xx3oW7AAXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mMkSgG2RfNTVpgY2YF0nRq6t16KEuVxybvn1sIi+I0Zs4WJsUR3g4kcAjKze62N87
	 3NnKIRcgPaKdUTdsrv5erOQqeyiDQOLsJwEGQqP/KzTJpvVfzocOLATO5Bni0xjawM
	 zaHAKsuMnroM35C9w69RcciXW8RXrvkrmWqY9ULIIusRQ6FNuiyNN6zC5J6afiuNMD
	 WIbNDABSs4WnJXx5I0b/+85Qe+PJTtvdk5+BvpxU6ckd/ysZ++wCuXX3o+Uv53ljuW
	 Abii+v/6TmtwjBwqDG9vdf/EYlRP39tWQW+Pp9gzv30J4unNaylLv5QzRQ6ujbztl0
	 PySwQy2JrALlA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251021144702.1582397-1-sean.anderson@linux.dev>
References: <20251021144702.1582397-1-sean.anderson@linux.dev>
Subject: Re: [PATCH v2] spi: spi-mem: Trace exec_op
Message-Id: <176165026507.34697.13320313092856106918.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 11:17:45 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 21 Oct 2025 10:47:03 -0400, Sean Anderson wrote:
> The spi subsystem has tracing, which is very convenient when debugging
> problems. Add tracing for spi-mem too so that accesses that skip the spi
> subsystem can still be seen.
> 
> The format is roughly based on the existing spi tracing. We don't bother
> tracing the op's address because the tracing happens while the memory is
> locked, so there can be no confusion about the matching of start and
> stop. The conversion of cmd/addr/dummy to an array is directly analogous
> to the conversion in the latter half of spi_mem_exec_op.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-mem: Trace exec_op
      commit: 77a58ba7c64ccca20616aa03599766ccb0d1a330

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


