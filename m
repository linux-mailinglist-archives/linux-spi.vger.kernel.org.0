Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7E1F9D5D
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 18:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgFOQ1A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgFOQ07 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 12:26:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9DC061A0E;
        Mon, 15 Jun 2020 09:26:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so8020420pfx.8;
        Mon, 15 Jun 2020 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GsXyMgxQo3eYWMgQOiRxBQADze+LhKM+ipQ94PZo12s=;
        b=sV+a2aIACIuf8T5L3j+IwsVsvdZHozCQD8jLxT2lUdqYMSd8YBR8CPoJg1Z/SRQK5v
         gTUNn/xFgJhRNE/e4b6m0lnPv2nCg/2SfXXTLC1Zcco8pfXFHrujlyU0kmWMi7VT1qZu
         mFXmJxhDMOcFyuq0X2iTcNVnqKIv6TMauQPhBuIuEy8cGoPZyjZ7qFvap7rNAgTP9Cp3
         H77A58aHOJEoF0Cv2yFsd5/NrW8TcARNdZZ/OJzaMR7zoJ5xMO6XQfMbLmZck7Fj3OUi
         pb/8iNFEiLWlvaL7ZuZ5LTbbp54AXrlqsUi6D5W6uUc2ppS4luUVK3yVGmN8CCq6GPqN
         XUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsXyMgxQo3eYWMgQOiRxBQADze+LhKM+ipQ94PZo12s=;
        b=eZLloBe2e6aDUwBZ9YUJ3A2MDTg41Uo+l/II5nyZntl3QrigS/uU72GyMqYD1YzMB6
         Q87BunxLNCrmfRTdMHzcNK/cRmoLAvtxYJaLm4A0xBecZoM2keQBi+/yO7TOJWDWYMdK
         K0wqNLHZibkfQToMewKc6/kVQGBYBFpzMvImRT0JTfSuBcSmpOPVCWW0OQ94Uyamcz2Y
         ZABEfXzsXFzAqrOlbZ25jzrgFY5Z0e/4Fb0a/yM2Ved+YRpQxlCTSPf3Xw5EAurMRIjv
         0Iru8Z931LYQHGqkFkXGDx70tdG4YBBDRPVZ9oBheixrhKaE4QiOLYV50Byz0zsh2pOP
         NDXA==
X-Gm-Message-State: AOAM5328FsYZnr5AFLqvZK98/1ufCIVYJdXr52huUvZzskQWSZLYoVrb
        1To37XkEukqxbK1CVJi/ajw=
X-Google-Smtp-Source: ABdhPJyUqbmrkkCDS9BI9tdTb6P2Sf2XkKphKAmeqojUCiJmZQNSV/i4yBDwpQSDcuGGUw90lpI+PQ==
X-Received: by 2002:a63:4845:: with SMTP id x5mr20769323pgk.94.1592238419111;
        Mon, 15 Jun 2020 09:26:59 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 204sm7184967pfx.119.2020.06.15.09.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:26:57 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] spi: bcm63xx-hsspi: allow building for BMIPS
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
 <20200615090943.2936839-5-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7060ec54-0288-9d9d-912b-593b609fd533@gmail.com>
Date:   Mon, 15 Jun 2020 09:26:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090943.2936839-5-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 6/15/2020 2:09 AM, Álvaro Fernández Rojas wrote:
> bcm63xx-hsspi controller is present on several BMIPS SoCs (BCM6318, BCM6328,
> BCM6362 and BCM63268).
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
