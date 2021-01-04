Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54C2E9C48
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 18:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbhADRmY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 12:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbhADRmX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 12:42:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E66102250E;
        Mon,  4 Jan 2021 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782103;
        bh=BPnOnznoiq/XSjggH+RhjSgHG7IZo/HAB190GGe8BNA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E9ebn3aaDsyTlV1sgH+066O2byDbBpr7WQHuTRleZn4w86BdM2QLxtROk9THLw0L7
         usZrstEtoc7TpqGMb4MsfcGU4nyPMCZNkus7/JA5xyL2Kln7k7N+5ixAP8XmiqD2FW
         iH0rPAoX4nb8Bl+MPX4NOqOiIiVSThzFsjzXaI1bP1JG+/NmqDeY1DGHLPUihqMNGK
         0vbmrHAUmYqR8VoZD9Aq3GTB8TFKTia6qw2re7QF4NCF3LcWK1BlvoCaFEhGVoLGrN
         jTcvSPJm6lMyz9c0hEM0MfPeL1SkXymY/2/TWJzvl7f56U+GJvgRsTUY0oSWrRPEF6
         aePWRdTjRrS8w==
From:   Mark Brown <broonie@kernel.org>
To:     linux-renesas-soc@vger.kernel.org, Adam Ford <aford173@gmail.com>
Cc:     aford@beaconembedded.com,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        biju.das.jz@bp.renesas.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
In-Reply-To: <20210102115412.3402059-1-aford173@gmail.com>
References: <20210102115412.3402059-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH V2 1/4] dt-bindings: memory: Renesas RPC-IF: Add support for RZ/G2 Series
Message-Id: <160978207205.14552.17083840940357811641.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:41:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 2 Jan 2021 05:54:09 -0600, Adam Ford wrote:
> The RZ/G2 Series has the RPC-IF interface.
> Update bindings to support: r8a774a1, r8a774b1, r8a774c0, and r8a774e1

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[3/4] spi: renesas rpc-if: Update Add RZ/G2 to Kconfig description
      commit: f4a10fc4225155ae4d2fcb411be9f24245bb5cf8

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
