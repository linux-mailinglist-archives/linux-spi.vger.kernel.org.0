Return-Path: <linux-spi+bounces-3687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D187591CEE8
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jun 2024 21:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0259F1C20E44
	for <lists+linux-spi@lfdr.de>; Sat, 29 Jun 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9E132136;
	Sat, 29 Jun 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9W/AoMW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF4980046
	for <linux-spi@vger.kernel.org>; Sat, 29 Jun 2024 19:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690982; cv=none; b=kXLAZfLFJ2lhI95yyAPJq6WAz59IqfwOpWwqR+wd3QFvGrROx2GQbTAUL8k3bPEU/Hf4RSOkvFOah20aXet5MvbtIscajF3+QgOcs84uoG7YPnIYuruY1/sa88xCW+ygKXLYfrrQUSYOHTuJsUgu1I2EPS+3YqwWAsD5IZ85FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690982; c=relaxed/simple;
	bh=WmBVThZmWNZJKU7aG3ZXv8OgMEMM0mrz2N0DrkvU+Qg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oKugNALDJvZdXsriA+LD2BickHJfl4cmcOQCapsYBnlU15QQHrM8GiLZjZfWjKlw6WnzCFVNoi+MjDMaQ36zdjDte9xgvG05xmlF66vNxqoYOI9O+Oj992Rm4Yi6UYZkNC6Jh9Sa9qjdyq3wNjOzBRJdqfRJLIbmVBv2Gq0tmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9W/AoMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4988CC2BBFC;
	Sat, 29 Jun 2024 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719690982;
	bh=WmBVThZmWNZJKU7aG3ZXv8OgMEMM0mrz2N0DrkvU+Qg=;
	h=Subject:From:Date:To:From;
	b=i9W/AoMWmZNj/nkzTr0CwzKLZC9p2KIG6NFx0vkv068qTf0H6TjPHpMRZUoX2pla5
	 JuWubLsuf2TvXgBmQzINkl3kSoHupIWSAOTXfh32N/7PFKYnOO7r2dkhRxlgxZxWvD
	 cnybKtiOr0iYe/4nWq8BShdoAQ6s4oBOxi+LzKAL1XsmSWWIoXUCJpwJ8CIkmk8kTW
	 q2IHlHY9UzzsAmBEXt24lnn7wwWeXl/cxiJ+FYIXhKH80S4TnVOVMp6HSyzBlkc6AO
	 o7tttKGNEFG0XMWVauekoxsTZhgzxkVXI7wu13SEXLWI9k9OfcEUjHN4YQdPIBgJvz
	 MCLdJ4mJ0IDKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 353A4C433E9;
	Sat, 29 Jun 2024 19:56:22 +0000 (UTC)
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
 <171969098215.10547.2133323138435972447.git-patchwork-housekeeping@kernel.org>
Date: Sat, 29 Jun 2024 19:56:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add support for AD4000 series of ADCs (2024-06-29T19:04:00)
  Superseding: [v5] Add support for AD4000 series of ADCs (2024-06-25T21:52:00):
    [v5,1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
    [v5,2/7] spi: bitbang: Implement support for MOSI idle state configuration
    [v5,3/7] spi: spi-gpio: Add support for MOSI idle state configuration
    [v5,4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
    [v5,5/7] dt-bindings: iio: adc: Add AD4000
    [v5,6/7] iio: adc: Add support for AD4000
    [v5,7/7] docs: iio: Add documentation for AD4000


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


