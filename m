Return-Path: <linux-spi+bounces-1293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2400851825
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E513282879
	for <lists+linux-spi@lfdr.de>; Mon, 12 Feb 2024 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D63D54B;
	Mon, 12 Feb 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8sIKkVl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D23D546
	for <linux-spi@vger.kernel.org>; Mon, 12 Feb 2024 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752003; cv=none; b=OwOusomDR2NF3Cl7NWe1U97esKtlQlNoK7zC+gzEi79z9lMn2XbOG0tn7qMncoS7qhfpIwW3Zgbz74UDPavSJ6+AaoNS0PP8A8whXyVDtGqTw2Q3CohY9w0RXmHTFwgSMja+7Z0YEqNtV8IZuk0+gr1CCSc2BQ5WzZ8TPWGn9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752003; c=relaxed/simple;
	bh=L8G4wM+me0B9N3Eit+hY4KbYDJI60DzdbLc7fycypxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ILV6mZcvzPMvojwB+5GojsoxkYTyZlj3OsDPHck6iae4BUW1wyj+yzVzbt/Q30w7bwXYeNE17hqt7vFdldNfB03eVHWUNxbmP7leHWXz/sL5YWlbn4dz6SCqbVQ4UDxpy/YznvNKHQ63HdttZy0rUBnEytfgK0eoAWmV3l5b+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8sIKkVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E66BC43390;
	Mon, 12 Feb 2024 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752003;
	bh=L8G4wM+me0B9N3Eit+hY4KbYDJI60DzdbLc7fycypxo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l8sIKkVlz6yO37H0xQxUTVIm5zDniAvJ6w72omneovAxBdc5AvUPHCJcYHP+PXLtC
	 VmnxRCTUqYJNViRJvEblDlpYHmziUTzn+hUGbZdci/7vw2cLcJzULjixkM1sk6S1rd
	 lGNiRTwrhq1hOYGXv1lVIErY5ZWnCdWvE1EsjQgG9jDBXyhR2J0cPFt2DYBiZ9p/FV
	 /wWcQkEHydKFt8gz+l25o5hNMS6QyMj8Fl6X9A2n1U7pKoKbY4BFSmLV8Q/JR+RsMO
	 LdtsbrCucowpDFuc2kaBlnHKhcbL1WQya1b3iTi/bp4TVY9SDhhoxKLaL8gNUCJNX0
	 tfxYWFjqWYAuw==
From: Mark Brown <broonie@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20240212082027.2462849-1-mika.westerberg@linux.intel.com>
References: <20240212082027.2462849-1-mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] spi: intel-pci: Add support for Lunar Lake-M SPI
 serial flash
Message-Id: <170775200234.46149.13888055662605951195.b4-ty@kernel.org>
Date: Mon, 12 Feb 2024 15:33:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Mon, 12 Feb 2024 10:20:27 +0200, Mika Westerberg wrote:
> Add Intel Lunar Lake-M PCI ID to the driver list of supported devices.
> This is the same controller found in previous generations.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: intel-pci: Add support for Lunar Lake-M SPI serial flash
      commit: 8f44e3808200c1434c26ef459722f88f48b306df

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


