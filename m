Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69B33DBC9
	for <lists+linux-spi@lfdr.de>; Tue, 16 Mar 2021 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhCPSAJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Mar 2021 14:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239548AbhCPR74 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Mar 2021 13:59:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36283650D9;
        Tue, 16 Mar 2021 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615917595;
        bh=LWv2RdOQ+K7J7vxOu5wGgipIwfQAL+SqFszPu4v3NEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSRXgZNTD4gsIDvZWY4dsu/7l90O0N9RIw0WJugAuyyjXs0q7aPL7MTwd4fhijGRH
         38qUdUVoSe7DCnKhkRALpnNpif3H96qMZNww5fo2r19IQant4EFuHArT7DX0G1hAf4
         91E8TWYhYMvP++bc9it8uzDRF8AH/jUO9c3bTlFAXuykEN+iLd+A7IE5R8v0nIOed5
         foO9cR5SmwR0jYZuyTFWFwkWNGFoSvechRJpz/PcMOFeCdeSGFKT6I/4A9jxu+u8Zr
         va4bXqylWZfG70d7EHn5C3gTDGqlymhg1PCc+Oeu6jq9gBdUW7xM8lMRyms7t3086h
         yMTxkCA8ZrE9g==
From:   Mark Brown <broonie@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] spi: Adding support for software nodes
Date:   Tue, 16 Mar 2021 17:59:40 +0000
Message-Id: <161591750212.14124.15654416621714459381.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
References: <20210303152814.35070-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 3 Mar 2021 18:28:10 +0300, Heikki Krogerus wrote:
> The older API used to supply additional device properties for the
> devices - so mainly the function device_add_properties() - is going to
> be removed. The reason why the API will be removed is because it gives
> false impression that the properties are assigned directly to the
> devices, which has actually never been the case - the properties have
> always been assigned to a software fwnode which was then just directly
> linked with the device when the old API was used. By only accepting
> device properties instead of complete software nodes, the subsystems
> remove any change of taking advantage of the other features the
> software nodes have.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: Add support for software nodes
      commit: 47afc77bbfeac163d81c7a675d608c18561aa680
[2/4] ARM: pxa: icontrol: Constify the software node
      commit: 2df0c4a640c55c0eff7f97907b98ad6fdfedd226
[3/4] ARM: pxa: zeus: Constify the software node
      commit: d4272a7adf26c62c5afe86b6829712de519b4a26
[4/4] spi: Remove support for dangling device properties
      commit: df41a5dad586c8ead1bb7082b4b6fcb563e02199

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
