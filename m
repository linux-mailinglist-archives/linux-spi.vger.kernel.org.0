Return-Path: <linux-spi+bounces-5721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B69CF66C
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 21:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928261F2336F
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2024 20:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F281891AB;
	Fri, 15 Nov 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QinLjsMH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317C16F0FE
	for <linux-spi@vger.kernel.org>; Fri, 15 Nov 2024 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704191; cv=none; b=GS5D0RF+0RmpHl9G5KbvlYh/GX6JNaIFH3Wi/fBcycW+froUQjhFWtz4WHOxINesBUd+R2QorysM+axVJJ5OF75e/TBJ08Zjb0vNbjtgYBY7GJ/qq9Tg35cYZdFakrJ/SEu9ZotTJ/WIdCXI/Uw89Ieau3tZLFPz52dGlPYwodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704191; c=relaxed/simple;
	bh=Th+4YFDpxQUl1Fnb2S7spPX2PQ5Y0eGj25PBNQtXv6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j+tsYTjisJZAkUGMWMsBp/fYcD/FN10mEUpFgsxk8U+CHLriQbAgCDjYII/oR+9TAKvIkcgFRdKEeCMFXnS6NIuBJ04HUW/etCXbcfgDBOw6XRxK0/Zb5nIYONkbbt2gtehp7ANcxC+2ADxw8H5KnfrrHImm2Krs8hIVADdBOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QinLjsMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F00FC4CECF;
	Fri, 15 Nov 2024 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731704191;
	bh=Th+4YFDpxQUl1Fnb2S7spPX2PQ5Y0eGj25PBNQtXv6Y=;
	h=Subject:From:Date:To:From;
	b=QinLjsMHzad/BTeAZ4u/M1zaGT1tzTaCn3v0QIcYH3xez1Vj4UcdMA/51s/BB99++
	 bm9PGHDu5msly4ie4OqoOK1CfSUpksKNh1Mb/962UNUiGnDFa7xyZbtVXSckyhBnXp
	 Vw49IkZ5VzhxuH9eJpNKXnh0AWeLLjBp7KFfHNWaPaqtA64Wmp6OyzFi/HNnm+stB0
	 gXju2m5+4gXnSAGOnolYAYreddNE3vFwV6jS5Tb6KzDbjm2pBcviUiw2vOxKXPaJa0
	 RggrT1Q+no/GQ6of6Oe7El4rXALNJN9CKA7MRsF8Yqw1U56P4WPtvCOgsefS5HFnsY
	 OYt/EPdNn7FnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D2043809A80;
	Fri, 15 Nov 2024 20:56:43 +0000 (UTC)
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
 <173170420173.2718404.15223305721931390192.git-patchwork-housekeeping@kernel.org>
Date: Fri, 15 Nov 2024 20:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: axi-spi-engine: add offload support (2024-11-15T20:18:39)
  Superseding: [v4] spi: axi-spi-engine: add offload support (2024-10-23T20:59:07):
    [RFC,v4,01/15] pwm: core: export pwm_get_state_hw()
    [RFC,v4,02/15] spi: add basic support for SPI offloading
    [RFC,v4,03/15] spi: offload: add support for hardware triggers
    [RFC,v4,04/15] spi: dt-bindings: add trigger-source.yaml
    [RFC,v4,05/15] spi: dt-bindings: add PWM SPI offload trigger
    [RFC,v4,06/15] spi: offload-trigger: add PWM trigger driver
    [RFC,v4,07/15] spi: add offload TX/RX streaming APIs
    [RFC,v4,08/15] spi: dt-bindings: axi-spi-engine: add SPI offload properties
    [RFC,v4,09/15] spi: axi-spi-engine: implement offload support
    [RFC,v4,10/15] iio: buffer-dmaengine: document iio_dmaengine_buffer_setup_ext
    [RFC,v4,11/15] iio: buffer-dmaengine: add devm_iio_dmaengine_buffer_setup_ext2()
    [RFC,v4,12/15] iio: adc: ad7944: don't use storagebits for sizing
    [RFC,v4,13/15] iio: adc: ad7944: add support for SPI offload
    [RFC,v4,14/15] dt-bindings: iio: adc: adi,ad4695: add SPI offload properties
    [RFC,v4,15/15] iio: adc: ad4695: Add support for SPI offload


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


