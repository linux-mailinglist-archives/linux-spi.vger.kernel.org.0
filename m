Return-Path: <linux-spi+bounces-3454-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46490E042
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 01:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6732814DE
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 23:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8830715EFA3;
	Tue, 18 Jun 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTWx6iN7"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4F13A24F
	for <linux-spi@vger.kernel.org>; Tue, 18 Jun 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755009; cv=none; b=QENjAIWnNJNy9emvfl9eLlk/08U/UeTX832dFlQMrysP5qp+WrKE+tI47ejxTFm1OKHVqQLeDGoWu8CqXMtPnflxKQX+VDP+VwZGQrEfc4zkMDBl5iYfdnNJFal/usHCIPHrThc7lj5Q3sQSdUZIxAmZMH37x5EM7kJ2wPY2NJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755009; c=relaxed/simple;
	bh=+snQ+euGSMJVgBbJGe75ZIz1PDL78bfmMODc9qSG/9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=a5Ezv2TagwT/e8kH35jQHqCfGxzd14smIU5Voy74oHMrz/9NJ6/r9xFY/o/fVFoyvWD2308vs6drt1Ix9uCOBCDmeZY54ou4pi5Bf+JrpmH69l/vIx+knG8e5tnXYEEOxoiWBAoS51/ek/IUkVMJ5kyyOFQLJGP0+mCc2E/FE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTWx6iN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0B89C3277B;
	Tue, 18 Jun 2024 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718755009;
	bh=+snQ+euGSMJVgBbJGe75ZIz1PDL78bfmMODc9qSG/9g=;
	h=Subject:From:Date:To:From;
	b=jTWx6iN7AfEwPYPPjT2ShasyGYNblqVDFOzIZyVu/x42A/iuqqVc8sD0Mss9+gMzm
	 5BYvA4D0LB6jrjgSg9zz3dWI0vSsaHWf1Xfc6+vlL5R+XF9qU4K36amEp85nrDOSZa
	 herYZTV17imneGzW48YTrdvo69G1QcULjMqxShVWFhqrbXVTKw0Kg8ytXoKZq59MME
	 9MDaOwFM81Qdxs4t1m0abIq9WNQcN7ZrWS/hsumxiaPwMr3YfxYvUuspEfEzTvUdlA
	 SAFkJZxHaeBSGkaSiTP5/PGz5q2CtGhHD/rL7Ye/0M0g41MYPIKYbmg4LWd704yhh2
	 HGlQtOtKDXZcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD51FC4332D;
	Tue, 18 Jun 2024 23:56:48 +0000 (UTC)
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
 <171875500889.1210.17461054550381780033.git-patchwork-housekeeping@kernel.org>
Date: Tue, 18 Jun 2024 23:56:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support for AD4000 series of ADCs (2024-06-18T23:10:07)
  Superseding: [v3] Add support for AD4000 series of ADCs (2024-06-04T22:40:56):
    [v3,1/6] spi: Add SPI mode bit for MOSI idle state configuration
    [v3,2/6] spi: bitbang: Implement support for MOSI idle state configuration
    [v3,3/6] spi: spi-gpio: Add support for MOSI idle state configuration
    [v3,4/6] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
    [v3,5/6] dt-bindings: iio: adc: Add AD4000
    [v3,6/6] iio: adc: Add support for AD4000


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


