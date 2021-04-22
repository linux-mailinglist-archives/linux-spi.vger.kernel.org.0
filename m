Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA6F368538
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbhDVQvc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbhDVQvc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Apr 2021 12:51:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C768C06174A;
        Thu, 22 Apr 2021 09:50:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so13328854pfo.3;
        Thu, 22 Apr 2021 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5hy0qPxKAuOQZxRaS5noQvTTz10EqbX0MqSJa7kt2Pg=;
        b=FcD9yoy6RlcWqXUPhd2KTdTTLd0BHzIngJHPCtCuyxr1w5fFUVPUyCBxI0s50OUZ6/
         WY8Hk9CifRaSKdJbpzJJ1slz4zi96tuJUIL7ykmGaUvr+eRmXDVetkWPS5jns05ZrqZM
         +s0UvyDKN1HAiqJfb5EI4ZHxa5N30wXdXFrPlRbispUt7NXbAfBr5uJCfTzcSh4huG1X
         3HQvFvFze4AdKrfM8cG3QN3lsC7qx21qi2JQyj7QDQBAudhP0oKnj6nc8XcCS+U5RzlR
         dNYEiVrfctoKDDLMbeDlsqtRnG96F7e/Uj26VPSgLQ2D8RCrysJNbliO9VRSPf17A3sS
         QCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hy0qPxKAuOQZxRaS5noQvTTz10EqbX0MqSJa7kt2Pg=;
        b=LaIPbn3j1OubVOztHSuGRmNfijuCcmS1lL9nxu3fqOUCS7gxZtxFH526Ef03/TaxsF
         +hHzrwB0sKU4ecJat7WGZ5LPa5zboD800fpskdyhvA4wu34odF3eb993Wr7NaHRdcVB0
         omEBixon0plP94gcKiNjepm1b/Ijat/Aha/qqIIeJrf3dYQMpWDy0ZtknQDiQTmkOczg
         aGzWPi6h525vG34lVVhqccxPZYvNRgGIYCnVvv4uqUzi9MvQBFW23c/QoUMqXbcHmLMM
         q96r6YUMQdLDmXQbyUUYk9dfGTVzSDLyJhR/MjPjk4s1kxMxEqVFxIbGq8CNeoR8jF4r
         FssQ==
X-Gm-Message-State: AOAM5328Yl0cRIdhQcn0xAck6/kvkqk1xY8QSxURBN/LPg4F/r3vXUiR
        GsLddb0nGXxdMwh9NBh1+POytSjkZHQ=
X-Google-Smtp-Source: ABdhPJxdJ60GHkYMKb5kIsdI6z/22Rx1Dprxev/IfzZZ0q0sXtjAPDEl/53ScSTDG9kabw9UYp4IYg==
X-Received: by 2002:a63:6ec3:: with SMTP id j186mr4442123pgc.249.1619110256371;
        Thu, 22 Apr 2021 09:50:56 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w7sm2610642pff.208.2021.04.22.09.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 09:50:55 -0700 (PDT)
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>,
        Mark Brown <broonie@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
Date:   Thu, 22 Apr 2021 09:50:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 4/20/2021 1:34 AM, Joe Burmeister wrote:
> It was previoulsy possible to have a device tree with more chips than
> the driver supports and go off the end of CS arrays.

Do you mind walking me through the code how that could have happened? We
have spi_register_controller() call of_spi_get_gpio_numbers() which has
the following:

ctlr->num_chipselect = max_t(int, nb, ctlr->num_chipselect);

such that what the controller has is the maximum between the number of
'cs-gpios' properties parsed and what was already populated in
ctrl->num_chipselect during bcm2835_spi_probe(), which for this driver
is BCM2835_SPI_NUM_CS (3).

> 
> This patches inforces CS limit but sets that limit to the max of the
> default limit and what is in the device tree when driver is loaded.
> 
> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>

You have changed many more things that just enforcing a limit on
BCM2835_SPI_NUM_CS you have now made all chip-select related data
structuresd dynamically allocated and you have changed a number of
prints to use the shorthand "dev" instead of &pdev->dev.
-- 
Florian
