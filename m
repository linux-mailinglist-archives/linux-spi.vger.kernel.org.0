Return-Path: <linux-spi+bounces-4779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418C1974626
	for <lists+linux-spi@lfdr.de>; Wed, 11 Sep 2024 00:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3882F1C25B14
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52D1ABEC9;
	Tue, 10 Sep 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Wq7uHu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297661A7040
	for <linux-spi@vger.kernel.org>; Tue, 10 Sep 2024 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726008633; cv=none; b=Qd2Kr3MdjfTvMDo+9RNoYWyQFv+UhHvx7g2j7iwkOPRGdrkXl+h82Ucr7FfFJoQOe6D7fRXBGIXvRqJrhdS+svBJ5UQpjjvB43FzGOdmjUo1/4uNRkHQx2ssRG+DTi7izHyHqYks3yyoCFbwI9B0i9IKRYJSHLwe3401qwFFvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726008633; c=relaxed/simple;
	bh=OaugiFQGe2F+cZXQboHdn/Jjggo1vZyLgKB5qxxScp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gliRiB8VTvrTTVuHux0R+V/6WCOJ3kcBgtwlWiIutBipw9DKNLkFGsk3S5HbSo4EuG3LV2+517EriyS/YENlkk8dtR0bSWGMS3rv2YQmFCj5lww4m3+ZSV+VKJ/Sd5I0JhHySU/NkQiHglgSb3FYSbCJWkrJMyiG7rcjVqSDIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Wq7uHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FE2C4CEC3;
	Tue, 10 Sep 2024 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726008631;
	bh=OaugiFQGe2F+cZXQboHdn/Jjggo1vZyLgKB5qxxScp4=;
	h=Subject:From:Date:To:From;
	b=X8Wq7uHuu/oe3MO9nOKYXa8NCBsQwXqxHCWh2+lYHKScMKpQXC2U2C+bj76MogK0g
	 OqIs1cKnLX9uAm2wROhZ7GkUrw9PxtH+W0dsTLSReM/3Nd9dNxqi4LNs1vHXllzJTY
	 KPjSsDf4tcI9lhsHd9iExcLTrRn+Ux/hkiKQdch4L9tENSH53Auvt0W5O8MHEMfUpD
	 NOrNTbcXUZnyBTzlHUkKJBjlU08bR0y2dWTbt3yoCgdNcFYXPK2oxtzZJrF3MUODER
	 23BSRTryOkwa2w2NQoxCDuiceHlbHOOduR307oJL0fro9+GxT71notsO9eIP8Kt4yv
	 SFDVpP+hVuAQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B768D3822FA4;
	Tue, 10 Sep 2024 22:50:33 +0000 (UTC)
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
 <172600863217.419409.10129782004620471194.git-patchwork-summary@kernel.org>
Date: Tue, 10 Sep 2024 22:50:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: replace and remove spi_slave_abort()
  Submitter: Yang Yingliang <yangyingliang@huaweicloud.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=888667
  Lore link: https://lore.kernel.org/r/20240910022618.1397-1-yangyingliang@huaweicloud.com
    Patches: [-next,1/7] spi: switch to use spi_controller_is_target()
             [-next,2/7] spi: slave-time: switch to use spi_target_abort()
             [-next,3/7] spi: slave-system-control: switch to use spi_target_abort()
             [-next,4/7] spi: spidev: switch to use spi_target_abort()
             [-next,5/7] spi: slave-mt27xx: switch to use target_abort
             [-next,6/7] platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
             [-next,7/7] spi: remove spi_controller_is_slave() and spi_slave_abort()


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



