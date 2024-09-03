Return-Path: <linux-spi+bounces-4544-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2B96A364
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E81C23F84
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB8C189521;
	Tue,  3 Sep 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4wAf0mO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8A189516
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378991; cv=none; b=SKo6hrUHfZQ0qB2RvbuXKmMsR+uSsYDi53/Z9HCLcQ7TV/jbwJhq430WeEV4CIbXvBmKh6WrxKoi2Dau2dLPrmt3w8FvjDA4su6JQ8DcPZzRNO+kZvIvRIBv2YflG38grUryUZ3V/iHzzEdq+C3/fn7Va0Ubun0dN1IotJPxT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378991; c=relaxed/simple;
	bh=cw25eOwMErTPVBLu+eCpBbx8x/ETxgtAqt9m4UmtEVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=HfvEToC7iBFu2b/BPliovpOaVHxUuQrGZMgoxvV0L+PwN7PB7B2XmW2zqk5O/irZBl2N8vUSBByMkeeBKgD13X+VAkQvMUw1orICoAvXl7x5ltZtHEF7hic0vtI1WdUz3NxK+U3ydeK6p8jVDZXF6gngLM5VklynzVb0UW9fP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4wAf0mO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C8BC4CEC4;
	Tue,  3 Sep 2024 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725378991;
	bh=cw25eOwMErTPVBLu+eCpBbx8x/ETxgtAqt9m4UmtEVI=;
	h=Subject:From:Date:To:From;
	b=c4wAf0mO3kHzRMFCRfYMch17Mkl3f6VIu4LxYFzzVLqvL8lUCANrr31aw+cgr57ok
	 LOVoY9Z1UKyFBKPwYlS6U/Q6ykS/VMQ9XX+AC+uDawe1qAlGCggZXzc48vRsBtbSIo
	 D2wq1BAU+qCZM0D0nrh1lXXJYxy2LfFksz95Fmfi+/fUolETAIbHAUaYBEzp+phRwG
	 gw3WFkokznEjUe1WKaO4/WTdnl2hknjGN+9A4F1RIVZUdqGeA8GQ4/GLpZow/qu1bt
	 lfDRq7lTAoJ7WxPKstiw7jdSk+jUvYeGbieRl0SAqVaqlQYPse5hfEI8ccEJvOseJP
	 xBfJhNxrIsKtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F583822D69;
	Tue,  3 Sep 2024 15:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172537899202.354046.17845728131213197629.git-patchwork-housekeeping@kernel.org>
Date: Tue, 03 Sep 2024 15:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add device tree for ArmSoM Sige 5 board (2024-09-03T15:22:30)
  Superseding: [v3] Add device tree for ArmSoM Sige 5 board (2024-08-28T15:10:36):
    [v3,01/11] dt-bindings: arm: rockchip: Add ArmSoM Sige 5
    [v3,02/11] dt-bindings: arm: rockchip: Add rk3576 compatible string to pmu.yaml
    [v3,03/11] dt-bindings: i2c: i2c-rk3x: Add rk3576 compatible
    [v3,04/11] dt-bindings: mfd: syscon: Add rk3576 QoS register compatible
    [v3,05/11] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576
    [v3,06/11] dt-bindings: mmc: Add support for rk3576 eMMC
    [v3,07/11] dt-bindings: gpu: Add rockchip,rk3576-mali compatible
    [v3,08/11] dt-bindings: watchdog: Add rockchip,rk3576-wdt compatible
    [v3,09/11] spi: dt-bindings: Add rockchip,rk3576-spi compatible
    [v3,10/11] arm64: dts: rockchip: Add rk3576 SoC base DT
    [v3,11/11] arm64: dts: rockchip: Add rk3576-armsom-sige5 board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


