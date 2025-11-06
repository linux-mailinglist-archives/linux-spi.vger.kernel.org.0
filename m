Return-Path: <linux-spi+bounces-11073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300EAC3AA4E
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 12:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F355D3BDDAF
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4B30F922;
	Thu,  6 Nov 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="capru84j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0FC2FB0A4;
	Thu,  6 Nov 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428861; cv=none; b=ryW0A07k0kJupfVmrgz/PRxMBG7lf5sBu6/mu+1qNlmf368pQZQ9WfTdA31P/qgsOpSPoz6Qt5gh8qWskYd5qJ0hagbk2kjrKgHdoNeJek9VCfbPSN5zSHm0tGodM1VPM5E4bQl+JVnK51wiWs+/kNbub2/1Zy6bnnF7EgdxQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428861; c=relaxed/simple;
	bh=BMvBp0vVYTdKvDSUYn73f7UGpreVUIWzVn6Q8Jb768A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PxbDPoFmnZOUHubTgdTgl+7+UgF6kFK91IwvD2Dq4OrFU3HJYRIH7nPsjtUaBm3xNKcPGXNX0estgfrlyrypkxtfYc/lMP7i/co3jJSJ1BgOEvGLDSCr6n8chKGe3YS3CLyjSTRiXLxgXPadtOlGSNJOMcScwz3AXFLoDXF4uPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=capru84j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC49C4CEF7;
	Thu,  6 Nov 2025 11:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762428861;
	bh=BMvBp0vVYTdKvDSUYn73f7UGpreVUIWzVn6Q8Jb768A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=capru84jwTfVANq97uUdwiKStahByghPYOfcSZsfq7pqGdSWPnZQX0ejEBzEqm/1x
	 hCPX8mxyjURRZeQDpwl1uf9BpSNKJ1k/WARaamJNL9BFjx3vl2s9Xh++0+A+nRu8k+
	 y8zVeQcnh5MAnqu0vYoTXoCpt3ZY06s9ibVXKjWU7iMpfAKiREQf55fzfeN6s+1irx
	 0QB7yl6Vg/8dQqU40OVcnTyk/g8PI3OMy88aWZgKD+j+vf0KMzJTxvqWYu1ZTw6TFg
	 PYehweac4njn/0tcc2ITP10V8kpAPZWKoOzDKTL16kRjNknJK1Em5t6ir7u66U5Van
	 uE82QDdn8kNOg==
From: Mark Brown <broonie@kernel.org>
To: joel@jms.id.au, andrew@codeconstruct.com.au, clg@kaod.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
References: <20251105084952.1063489-1-chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH] spi: aspeed: Use devm_iounmap() to unmap
 devm_ioremap() memory
Message-Id: <176242885811.2357454.3184590153610422112.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 11:34:18 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Wed, 05 Nov 2025 16:49:52 +0800, Chin-Ting Kuo wrote:
> The AHB IO memory for each chip select is mapped using
> devm_ioremap(), so it should be unmapped using devm_iounmap()
> to ensure proper device-managed resource cleanup.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: aspeed: Use devm_iounmap() to unmap devm_ioremap() memory
      commit: 2f538ef9f6f7c3d700c68536f21447dfc598f8c8

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


