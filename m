Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A263781B
	for <lists+linux-spi@lfdr.de>; Thu, 24 Nov 2022 12:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKXLx6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Nov 2022 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiKXLx5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Nov 2022 06:53:57 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDAFC5B67
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 03:53:56 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id k2so838046qkk.7
        for <linux-spi@vger.kernel.org>; Thu, 24 Nov 2022 03:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rryA0sPrDrTCCNWf9O977x3hl7j7UIOszCkFi8a+0vU=;
        b=M1fKV4ZRVo7xIlGVuaF7t2g0y+VoalzFOSoIZzbKppEgf13GYQCKg+becMT7xl2AFD
         pMnOLVnChX4Md0OKrxSVb8q3dkKGQ/YhUX6MKFgE6klyfx7JxE4ovFPXbTrPhs0sA815
         m5q8ajEaI4PxQWmytQLKv0WAXjxZT2bJGekk1PAVKtR1+KpKrihMvlbrlOQkCrbY8zJ5
         SDkGUvhVjbzVxjQukqGG0YJ4Shae7r6cb/8OKziPh4NSlWGO1qGOpyr1KILujCc1RcZS
         JBC2NnziXM/+oaUGNdP5gpbQfUEZkb2u6eS0bgPvLlUnV8pzPuHvZ0xSsPzb/Veyv7XF
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rryA0sPrDrTCCNWf9O977x3hl7j7UIOszCkFi8a+0vU=;
        b=P4nyQWJUq+WGQnkRh3mAu8MWPDZ/OGTeVBoMvRWVEEb2DNhH3H4ROR79CtyrRKWT8S
         7pqIpvJ81jR1CUq50GWUBAxcHoVp/wcd4rTCtoLy4vq8ghYQchp1u8xKCQxu8TDCYjo1
         3k5ms265dsKFbXFnosUpmhgWfCnJ3n6l7YDkXK9L2+6DY+eSO7tAgSC7QPTLza1bsPj5
         JyyGGlqHjLyP0rta3bkPsGRL1obirxNtMx8BnGvftnl39HsU8XMqJ3eGKNvKfa/uXpdl
         vjDF9iVVOJAfYDercSY/nEUsrBqaPhEgaGU74NE1w5dwiiKx7VqvtpWpOpuv2FzaS6/x
         cHtw==
X-Gm-Message-State: ANoB5pnNuTYwE0taBpytEEVSMZ/SLl4ForWKO/DBLVj2i1/HLTlrD3AI
        K84V7RHgE0e9XrujT1rsyTQSMg==
X-Google-Smtp-Source: AA0mqf5QMtc+zdSfKNrw334C5/+oKFRt4VNjgLW7MTaH2zf198kYMHQLLb86ghmYIKXIZX/wYuvlbg==
X-Received: by 2002:a37:6897:0:b0:6ed:9450:9f3 with SMTP id d145-20020a376897000000b006ed945009f3mr28003911qkc.573.1669290835959;
        Thu, 24 Nov 2022 03:53:55 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id bi4-20020a05620a318400b006ef1a8f1b81sm753851qkb.5.2022.11.24.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 03:53:55 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
To:     broonie@kernel.org
Cc:     greg.malysa@timesys.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, nathan.morrison@timesys.com
Subject: RE: [PATCH] spi: cadence-quadspi: Add upper limit safety check to baudrate divisor
Date:   Thu, 24 Nov 2022 06:53:54 -0500
Message-Id: <20221124115354.132832-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Y39YJL02jFbkEMqw@sirena.org.uk>
References: <Y39YJL02jFbkEMqw@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark & Dhruva,

Your understanding is correct.  This is just checking if the divisor field has exceed the bit field's full scale (0xF) in this case.  This was observed when we had a reference block of 500MHz and a max SPI clock of 10MHz setting.

500000000/2*10000000 = 25
25 > 0xF (15)

Would you like me to add a dev_err (or such) bailout error condition and resubmit?

Sincerely,
Nathan
