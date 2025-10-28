Return-Path: <linux-spi+bounces-10869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB89DC14538
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE5CD5026E2
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EE3054EA;
	Tue, 28 Oct 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT9FS73k"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA78304BC8;
	Tue, 28 Oct 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650265; cv=none; b=amQfjMIv4QeJcEc63EsA6CJedWonfshXDU+0KHGXiUIlIV76xOoDkAOZzOeVXR/4m7zBBFGR/2C1N2B8w56NMDJ9q+cwQaZstDqSJVSQmGHYbUnZuvBdnt+qj3n/Kds0geXjmR5aSojhGAb0VrJO7xRVZug6LImCxJVEqQQqJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650265; c=relaxed/simple;
	bh=xzg9bvQL9DeNL2DTBfN/hDTmDfUQAk/U5um+jkOwfgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kh4EpPGAxGXRaqRWsZMBRvgH38tZjIri/SIs04UK9a5uROFXyg5KsS0B0HUIZRLbF6RtTpyVgnpZrzs+HWFGcQ/YlzLuwrrentqct+IVwXDX6s+X99N0Lr277ftJJD//JteLizd7Z8hiXS8dra36iuRLkeOqSTyDpWDfvid/Kao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT9FS73k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABCCC4CEE7;
	Tue, 28 Oct 2025 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761650264;
	bh=xzg9bvQL9DeNL2DTBfN/hDTmDfUQAk/U5um+jkOwfgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BT9FS73k0cCW8H/Mu8MBAwGZZz7abNeN1adsSKaYCJesiSpDWp0teicmjGIYC6JSs
	 2N2dmLjSu1iZ3WLyb1H331b8KJ3MatHxEZJ/lMLeYZhTA89YY2qa5IBhHTFzDSZrap
	 LfJgnByD9a0pVIJbyaSXbm8rTGnrFM+l0ELpaU0Gu0bN053vbFqnK2HjjTjN9rCbT5
	 rA+RiaqENMtVPnmJRYcT7/9u2nVYiulIY1ckW8hZWIJfY63xPaVG6gCt/cH0Cvhz71
	 UmixocY5LCCJcYpBrCv6FZGygKy7xWfaSmHb2+kpHznZyQeQkl7qq+pvPmCSsF2M39
	 d3qC9dWHQfQUg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20251020190333.1431664-1-sean.anderson@linux.dev>
References: <20251020190333.1431664-1-sean.anderson@linux.dev>
Subject: Re: [PATCH] spi: spi-mem: Trace exec_op
Message-Id: <176165026321.34697.8358441420241761264.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 11:17:43 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 20 Oct 2025 15:03:33 -0400, Sean Anderson wrote:
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


