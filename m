Return-Path: <linux-spi+bounces-7261-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BACA6AD4F
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 19:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F158A3050
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AF722333A;
	Thu, 20 Mar 2025 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ki6gFy/G"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231321E8339
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496679; cv=none; b=hM8P+IO6AGBMKoiBI65KHF9faHd8DmksjoXIk2m8Uo7OcGmZyMu7Rgo6UzMnBBoTQIomabb3TKunRNNr+7rJUQy6CskYV55lCl/QhxYTO1ID/420V/9gqkZb/rFgDkghDBROHVldi+ycEMKLuAXhdwE/6d41xDa+t1/ei0oeEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496679; c=relaxed/simple;
	bh=YKhsv9SRarobZbsTtgM/rrm8TUtuU88gubDFJIcweO0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TdoSnSbphEMBJ0gotxpwbR+MQbgHJXRpjRV+Mp3VVrDH80Vil4kiZhgAw91QbUzTaWPDAg7uijRGsb/1C6KpN1GLoCOGgREvi4yjXK2Y4GK5373SvsrIUjPURmW7CSKWmj1/DbUM8G+OnTGWjSFFENDKs3vBCDYMMUOFnllBjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ki6gFy/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE19C4CEDD;
	Thu, 20 Mar 2025 18:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742496675;
	bh=YKhsv9SRarobZbsTtgM/rrm8TUtuU88gubDFJIcweO0=;
	h=Subject:From:Date:To:From;
	b=Ki6gFy/GVBsiWNKAabIQ9xZV1O0tI8LfBm2xOs1JuPinfF8R4uq7zBLNfkhbjsRny
	 XkESPEX5VFSlU7SPIATleUZt3HwzAG82ueieQuwVN+oX9g/Bd9t2gYVyeOralcCTtX
	 x8ro7eKulEemH/UxZA95extyGqQm9KhdyhbY/uzrrXevVNSpKKvpd99hVVqLcx7dms
	 yVX1E8hQFJg2raSnG4WdursImdrjuA2gjW69daCiO/byD5TRO9DVbTtPOcKsNZh+l2
	 +vLL0qYn892WRSjb3KOyT0fRpzacHJtDdTNCmohmP4ojzN6tUPVcK6sthQy5lwpxbO
	 I/SCWGo97bD3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7C04F3806654;
	Thu, 20 Mar 2025 18:51:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174249671109.1873551.12553458970365081299.git-patchwork-summary@kernel.org>
Date: Thu, 20 Mar 2025 18:51:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: dt-bindings: cdns,qspi-nor: Improve description
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=945522
  Lore link: https://lore.kernel.org/r/20250319094651.1290509-1-miquel.raynal@bootlin.com
    Patches: [v2,1/3] spi: dt-bindings: cdns,qspi-nor: Be more descriptive regarding what this controller is
             [v2,2/3] spi: dt-bindings: cdns,qspi-nor: Deprecate the Cadence compatible alone
             [v2,3/3] spi: dt-bindings: cdns,qspi-nor: Require some peripheral properties


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



