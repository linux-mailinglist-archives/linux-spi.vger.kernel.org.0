Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2943491A
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTKmv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 06:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhJTKmv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Oct 2021 06:42:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 573D461260;
        Wed, 20 Oct 2021 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634726437;
        bh=woMXR+DvWYmfLLqPewSY7ognLmZtK+VaDHey2LOeLM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbN4d/ecW/xwfPPhyJtV+a5gIAy5lprQ5TiB+etYaPrZRG/XgAv66tx9gyF4DUMb/
         s5GaLWmjO4rj3RyKJ5+bXwG/sUWNK9KK4ldSVPed5XdxxC0j8vY+bt0TUUGCo2Ics9
         1j5Ou8z2gEyE2J/bCUh7MK5PISA+WXdknwN3gjqu+HmUSDcDzHXvEA4R629t1oKyye
         4Mbq4O+Zh5emw66beV41ibHYkC0pU5bbA6S+/sdgb9hWDjwoZSjLah4e5jqL5PwUKX
         CR8AojSl9K04IyzPX0fJidxhs1XJXLR/P1TP4JqIRlegp4sjljnoK2Wlri5VYS2xMo
         Qpt3jRm7mRfKA==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        radu_nicolae.pirea@upb.ro
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi-at91-usart: replacing legacy gpio interface for gpiod
Date:   Wed, 20 Oct 2021 11:40:28 +0100
Message-Id: <163472624798.3119242.5591759976145691233.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YW8I5Emdc3t0cqhz@fedora>
References: <YW8I5Emdc3t0cqhz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 19 Oct 2021 15:05:24 -0300, Maíra Canal wrote:
> Removing dependency of linux/of_gpio.h and replacing it for
> linux/gpio/consumer.h
> 
> 

Applied, thanks!

[1/1] spi-at91-usart: replacing legacy gpio interface for gpiod
      commit: 3340ec49ba2c294a163d05319054c8506a8f30d9

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
