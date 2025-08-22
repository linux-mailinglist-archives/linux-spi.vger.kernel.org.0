Return-Path: <linux-spi+bounces-9600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6721B310E3
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 09:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CDE1CE6003
	for <lists+linux-spi@lfdr.de>; Fri, 22 Aug 2025 07:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FA257820;
	Fri, 22 Aug 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7DNJgKH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BF2EA499
	for <linux-spi@vger.kernel.org>; Fri, 22 Aug 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849396; cv=none; b=O1lGcfhCxbWGKPaCkfY6b/Yroiea7y/q+4OJnY0Cs0NtGudU2A9nNtmKvP4cY2H08K29EpLPNiuC5iCKkzccsEHwMkfM7PLtSZLJYCZyUv/gZT3ClK1v422eDzPsg4gpVitcgda7AH8WEQFN+L7Gr4A6/sNOS3E8MjXjqamlwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849396; c=relaxed/simple;
	bh=Lvz66Zvq0tONGz327dlMdcYoPmzg2IFZx7IBRNrA7RQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EbVq48gRNHEcQgg6YvHpwpe1KsMEC04wJjxPxazoRg/WKKQxqPb9HdB/IjHZxiYaRCq4FDka2Kz2MQ1dh/Az0n/djxqwGWlEfGHm/6t66z5mkrVnJ2tblajAD90qQMZ2T+7UuGYh7caRNWlNl7FrszFAqrIqj7YGbZMSIt9zyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7DNJgKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A9C4CEF4;
	Fri, 22 Aug 2025 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755849396;
	bh=Lvz66Zvq0tONGz327dlMdcYoPmzg2IFZx7IBRNrA7RQ=;
	h=Subject:From:Date:To:From;
	b=A7DNJgKHNf7i5HqC9C7GKsYp93SRqzQk1EgeLL18jOfX3o5u0IEm9dWYHx97ivkLM
	 ZqRo7s4MM1LYZ8tSyI+NHCuob+l4OJOvH09rJBMuOfqMkv6oOkI5o9UXhaFhooPPhf
	 4lCpx7fKS1j6epweCM+5gD7kPbvXA6KgiOY9ni+FTgUv3zIt9VMjB6uDh/zHFwgWJW
	 Mlv7syJtJhrXXZ++Ivma+XyFLLMWgobuSFubPQHdZFHmuN4gJHLAuGPI6zDCNqU5xI
	 ydu42jhB+xjc8BRiNHv8x8qRzV9iC0ELKyh9Gw1ESSWJTPw2UvDdC+F0TLrCI5fEyk
	 vmWZxIrq9OOpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCD383BF68;
	Fri, 22 Aug 2025 07:56:46 +0000 (UTC)
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
 <175584940469.1728222.17287895631703475722.git-patchwork-housekeeping@kernel.org>
Date: Fri, 22 Aug 2025 07:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add support to load QUP SE firmware from (2025-08-22T07:26:45)
  Superseding: [v5] Add support to load QUP SE firmware from (2025-06-24T09:50:57):
    [v5,1/5] dt-bindings: qcom: se-common: Add QUP Peripheral-specific properties for I2C, SPI, and SERIAL bus
    [v5,2/5] soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem
    [v5,3/5] i2c: qcom-geni: Load i2c qup Firmware from linux side
    [v5,4/5] spi: geni-qcom: Load spi qup Firmware from linux side
    [v5,5/5] serial: qcom-geni: Load UART qup Firmware from linux side


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


