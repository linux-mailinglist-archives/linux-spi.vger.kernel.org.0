Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE82FACA
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2019 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfE3LUV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 May 2019 07:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfE3LUV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 May 2019 07:20:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559215220;
        bh=pMVaOpeL3sd9BwsJOoYLd2cxL9/a5VPV7w59CDayVNc=;
        h=Subject:From:Date:To:From;
        b=iwvMhDdvSGXwyEr9rjXelsD+uxiKlhFuxmNulU/k05AGxEkEYrojJ1Bhm02hsgXDg
         NfcxN5f9oMicMrxhHGJEuaqqeBK4NjKQIjX6zj39CLe9U2RfdN/sROlxS7ksizz+2O
         6jF/qoN3Md2nYZxAc8SJXs6AIEjopET4gB4CpKNs=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <155921522081.23226.1237632739601195442.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 30 May 2019 11:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi/acpi: enumerate all SPI slaves in the namespace (2019-05-30T11:16:34)
  Superseding: [v1] spi/acpi: enumerate all SPI slaves in the namespace (2019-05-28T16:40:40):
    [RFC] spi/acpi: enumerate all SPI slaves in the namespace


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
