Return-Path: <linux-spi+bounces-4811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47E978A6D
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 23:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7C63B2099F
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 21:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7EC1474B2;
	Fri, 13 Sep 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpQtVC+X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B60126C01
	for <linux-spi@vger.kernel.org>; Fri, 13 Sep 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261655; cv=none; b=Fh6tAvi7GSlHRyMdAZtCA+X0fd3YU4bJOcvZvPVkxW+h9/3EEa82GRLzMDm4HbELavwSYJ6LsRrE+MjqwMfVQvBlHVaCXlW5GppKUsWgBy2nNeMxvBmygxhtA8Mdc8Xc1UD0FzsjH4NFwROiTMyxf6UEax5LZZWKvc8V5hgv2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261655; c=relaxed/simple;
	bh=v5sSkA0jlaSImt4DhnMUShuUE1jfcGrQVv2WwaU9BZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m35WfY/XRvzkBiG2YUfXZqWzHxbLAoeFurklLhn8gThxRzfr2sGmoWYL/e8Z4ZY0FzU2HTQ8kqHWaG2f3glwOaSpv+Ky2dmpRhmOjXReCTAo0JmZrxQUbU9elRz5IhMOq37p9USm4FWHIfXj8mkf/Ht87xszZRIgJ5SwEwdDgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpQtVC+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC16C4CEC0;
	Fri, 13 Sep 2024 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726261655;
	bh=v5sSkA0jlaSImt4DhnMUShuUE1jfcGrQVv2WwaU9BZ0=;
	h=From:Subject:Date:To:Cc:From;
	b=JpQtVC+XY936FRrW7vcD3/MA5gc11hak1sMWuxhzwFxqoHR4dpspS35HW1k+SzF+g
	 XvPoFTAAA5tU4dOlOPD7JMqZA+EWI0vpPsNI9vB/d/mJfZ34VPw01afK75tXRzMvUg
	 BFl03VFOLkhZpmys/77NcjN9sOPrYYHi3OqQj41vFnZgqCfh1xuDVCNdyXUg91/vaP
	 anl8LtnF9df4PU7ULoHmthUEne8DY+C9/O8LoRS8sw0PkNSgt/mKre01mBvsJL7mRu
	 9PD4RVwSUn+Gt7kKHgeKHnf8VxTTVnVfDYMzM75eEuZl/LhfAerFx/YY20N+ncmsL8
	 SI0MRK1Mt7nkg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 0/4] spi: airoha: Fix errors reported by mtd_test kernel
 modules
Date: Fri, 13 Sep 2024 23:07:12 +0200
Message-Id: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICp5GYC/x3LTQqAIBBA4avIrBvQ/sCuEi20xpyNigMRRHdPW
 n483gNClUlgUQ9Uulg4pwbTKdijSychH83Q637U1gzouOboUApj4JsEp9n7cdDBWxugbaXSH9q
 1bu/7AZ2uWaFiAAAA
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

Fix errors detected running mtd_test kernel test modules.

---
Lorenzo Bianconi (4):
      spi: airoha: fix dirmap_{read,write} operations
      spi: airoha: fix airoha_snand_{write,read}_data data_len estimation
      spi: airoha: remove read cache in airoha_snand_dirmap_read
      spi: airoha: do not keep {tx,rx} dma buffer always mapped

 drivers/spi/spi-airoha-snfi.c | 199 ++++++++++++++++++------------------------
 1 file changed, 87 insertions(+), 112 deletions(-)
---
base-commit: 58be528df758d3f00c10d6d381d9e02d5c68f23d
change-id: 20240913-airoha-spi-fixes-56bb430fb99f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


