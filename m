Return-Path: <linux-spi+bounces-10567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541ABCE922
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A914012D0
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0425784B;
	Fri, 10 Oct 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McQqiDqn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E992475C8
	for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129808; cv=none; b=X3cK6nWKGD8HnKjAc0G+davmyB30hfioxZPXorn2qI4xBdstZSmCV1iu1nMfKLmh/kqgEelsRI6a2MNK2TQMQZQf6D3KUwT+uZcWno3w55QqjDL144+X7kTZxg1A1xqshPJ/eKKBPkBTYnhz+xmNItkAPD0t/T6MdatTQ9itE2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129808; c=relaxed/simple;
	bh=E2Wnj5dk1vJ7hXTqaxNiskTCDH5rstcQ6/7G48g+o3A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=R+u8atWFbvis7OskRlMoE5XkN5hhFRpcRLpnmpAfJ+EmFGuLKPlFepC0VovVXm4ShNNxFSJ88bbahaNDKD06yqXF/wqcT3iVM7asNFULZ5tGz5HTGDw0ItAbgDo+pPvYI3KVIGQM/A8slQJDK+eqNLLdXIOLn+5xsKW5SKv0JcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McQqiDqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F24C4CEF1;
	Fri, 10 Oct 2025 20:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760129807;
	bh=E2Wnj5dk1vJ7hXTqaxNiskTCDH5rstcQ6/7G48g+o3A=;
	h=Subject:From:Date:To:From;
	b=McQqiDqnq0OuSTi+OnugvbONFnYTmzmmpJ+p/lZyWtpP377iuGgcE1RQcQxMp6djP
	 FEzehRS57QWZQI+he3R081eR7OI1IQGkK/P7ZyKDI9JNxpbkJAb+5qcQgCNKu5N7+W
	 1P4ZDfcuy8sNuMYlS8YWI09yWsnETUJVRv0PoJSI2CZxQpvSrHCITHIEj2tqZTFkbW
	 cDdcEHK+Ch0Pi1MPnsU9HdCF5NxF/V3RoYfWeM2kRWdDTFa0DYsCkft4af9lqwXhvF
	 +XEKSyDeXbGHo518kfmVIdgje4qlm6b9NBI4OAFvAJF3cRXOuuamer7lY0bQQwdZ2+
	 aVrV7CGvXOq2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECB3809A07;
	Fri, 10 Oct 2025 20:56:35 +0000 (UTC)
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
 <176012979425.1125223.9699151370110754682.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Oct 2025 20:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] spi: airoha: driver fixes & improvements (2025-10-10T20:44:46)
  Superseding: [v7] spi: airoha: driver fixes & improvements (2025-10-10T03:31:19):
    [v7,01/17] spi: airoha: return an error for continuous mode dirmap creation cases
    [v7,02/17] spi: airoha: remove unnecessary restriction length
    [v7,03/17] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [v7,04/17] spi: airoha: remove unnecessary switch to non-dma mode
    [v7,05/17] spi: airoha: switch back to non-dma mode in the case of error
    [v7,06/17] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v7,07/17] spi: airoha: unify dirmap read/write code
    [v7,08/17] spi: airoha: support of dualio/quadio flash reading commands
    [v7,09/17] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v7,10/17] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v7,11/17] spi: airoha: set custom sector size equal to flash page size
    [v7,12/17] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [v7,13/17] spi: airoha: buffer must be 0xff-ed before writing
    [v7,14/17] spi: airoha-snfi: make compatible with EN7523 SoC
    [v7,15/17] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
    [v7,16/17] dt-bindings: spi: airoha: add compatible for EN7523
    [v7,17/17] arm: dts: airoha: en7523: add SNAND node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


