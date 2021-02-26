Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7C326506
	for <lists+linux-spi@lfdr.de>; Fri, 26 Feb 2021 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBZPzo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Feb 2021 10:55:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZPzo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Feb 2021 10:55:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11QFrig0049424;
        Fri, 26 Feb 2021 09:53:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614354824;
        bh=yiOWXq3QGq+zyzBZNn3bYbgD3SMp1ZEe2lFcIhOGHDA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ajT1SAgByr/HSevu6lSyi95S7jSLE4rhdCuEiQ1RCwPJzHwe1XBkNtXo2EZafWCEF
         UFND9BR61PhecPCVC27rYEpKZw43pW4RJpWQOcGXMI5lm+M+0jY2FyzKyQe54T6MF/
         YwO2OV+XU1Iz8P3WHhN1gVmoQ1sifbHZHN4hJe4E=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11QFrixW104275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Feb 2021 09:53:44 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Feb 2021 09:53:44 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Feb 2021 09:53:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11QFrhiR071039;
        Fri, 26 Feb 2021 09:53:44 -0600
Date:   Fri, 26 Feb 2021 21:23:43 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jon Lin <jon.lin@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] [v2] spi: rockchip: avoid objtool warning
Message-ID: <20210226155341.cqqkmu2g6mmy673s@ti.com>
References: <20210226140109.3477093-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210226140109.3477093-1-arnd@kernel.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/02/21 03:00PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building this file with clang leads to a an unreachable code path
> causing a warning from objtool:
> 
> drivers/spi/spi-rockchip.o: warning: objtool: rockchip_spi_transfer_one()+0x2e0: sibling call from callable instruction with modified stack frame
> 
> Change the unreachable() into an error return that can be
> handled if it ever happens, rather than silently crashing
> the kernel.
> 
> Fixes: 65498c6ae241 ("spi: rockchip: support 4bit words")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
