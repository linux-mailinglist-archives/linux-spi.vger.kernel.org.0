Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10436063E
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 11:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhDOJyD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 05:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhDOJyC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 05:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A3696108E;
        Thu, 15 Apr 2021 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618480419;
        bh=ADODfuARmar5XlQu+qdM/TYV8hvB2mj+V7nC+qrXlPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lJlX7U9An9gVj5uDMMk9Xajw1JP/Ci+8cjnv93MDYTydnqf7orpf08CImJRpGdFdC
         tqg0J75Wx0oqfrxo8DOYrVcjKNY6kVCWBi3qXQ7AsA1zMPrYGdubV1mFKytT+ZWZpx
         bUG0AmN8ZPgL1CCAeABm/4ndGJzlGDae2AjOx2Zuxnw9IgZyT/+GqtVtiwkjrDUho3
         GUwpKMe0mUYU31AeXPX8LzhAfypi5CIfX0q02ymFA18ayMnMoSo/c946tuTiIW2odB
         bDPjfRZ45zHuP5T4//ydaLlEw34aXbqUGte3+9jUsNlJcZHhWzIxLSrwcXO/CMpyQp
         upOJfBMOGepxw==
Subject: Re: [PATCH 2/3] spi: s3c64xx: correct kerneldoc of
 s3c64xx_spi_port_config
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414203343.203119-1-krzysztof.kozlowski@canonical.com>
 <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <d51a4940-737a-7667-4223-6a5c92133c38@kernel.org>
Date:   Thu, 15 Apr 2021 11:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414203343.203119-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 14.04.2021 22:33, Krzysztof Kozlowski wrote:
> Correct the name of s3c64xx_spi_port_config structure in kerneldoc:
> 
>    drivers/spi/spi-s3c64xx.c:154: warning:
>      expecting prototype for struct s3c64xx_spi_info. Prototype was for struct s3c64xx_spi_port_config instead
> 
> Signed-off-by: Krzysztof Kozlowski<krzysztof.kozlowski@canonical.com>


Reviewed-by: Sylwester Nawrocki <snawrocki@kernel.org>
