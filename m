Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4226DFABB
	for <lists+linux-spi@lfdr.de>; Wed, 12 Apr 2023 18:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDLQCR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Apr 2023 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDLQCR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Apr 2023 12:02:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3C230FB
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 09:02:11 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dm2so30216348ejc.8
        for <linux-spi@vger.kernel.org>; Wed, 12 Apr 2023 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681315329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P48L2Jms2Mp6QzX85RJQL6rPkvxl9viUzpg3pDnhywA=;
        b=Lai5PkIyQCzklsH0xyC+KuF8+s/1OGIhKzIfcGJEVxuNpN7EtGWdOf0ceA8OLg5FZA
         cJuoN0Xy4Zl2QEh+4AuMkfmkUXGKZkALNJG1jKcAcQcNXZfo7apLg843oJ/tx1uKhsKN
         aGm6fVgJUmUtbu3MvmBoT6G0UsLtMC1rhOaLZUKeIB4QcG648Pvef8YoB/Qjjjjeg6uq
         mlt2dyIZmM7304hZKMUKkVqXH8isGGfYETcQn4igrzF1TdLyMzvMAJVW+4DuDOPVlVO9
         C7c2Rpjp4/JnWCkar8Yf+32/vUWoUqKX6HQCFPRk/qxgVMY7NoUkwK8EoVUTk/q8F3Hz
         gOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315329;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P48L2Jms2Mp6QzX85RJQL6rPkvxl9viUzpg3pDnhywA=;
        b=YZ1oBzAPjJguCD4H9jKO7YpvbVucyx1Cq5HRmviwk8GAdqClUcxrZ+RzmOTOQA7d/T
         w1p4WLXPK4WTorvbbJgA9Ly0HbzgQqF0sqPwNAyXQQEM+aIt+1IE5rKS0eNhBBRg1Axc
         brjzbb8p8AYdh/+oGF7wP3XqpmrPxro3g8gU3GazOpqBEx18P7nu46PE2je9Yu0YT+QU
         yG0/ox+s8+1dZo95Znplz3NElt9MMccgqD3Y7sbpq4zptMuEm0Bxs7q2u4d1H9gqBuYa
         ls3Fb0C8e9OpGYvRm9MY9E7KEIouuexPk1lrNcVRg7KWDlENygy20ntjCzv9OOP/ETJ1
         4XPw==
X-Gm-Message-State: AAQBX9cV9q7bbuukpLLE/Oa2pnQieeSzJVOuW77W7CzRP/ooC7QeqZM8
        km9HNmqZEGGz+xvK9lofebe0nA==
X-Google-Smtp-Source: AKy350bIU+DPRpNt+AG2dZO4oeQZ8duG9CBBLaQ6Y6Il6uHmY/Z2JbJZC1wmNgYIDp4L8HtlD0yjSA==
X-Received: by 2002:a17:906:4154:b0:878:545b:e540 with SMTP id l20-20020a170906415400b00878545be540mr2163737ejk.51.1681315329630;
        Wed, 12 Apr 2023 09:02:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id fy36-20020a1709069f2400b00927f6c799e6sm7311909ejc.132.2023.04.12.09.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:02:09 -0700 (PDT)
Message-ID: <62e99a2d-f3bb-28b0-37a4-e1d86bcf8a80@linaro.org>
Date:   Wed, 12 Apr 2023 18:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [V2 2/3] arm64: dts: qcom: sc7280: Add stream-id of qspi to
 iommus
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1681313387-8376-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681313387-8376-3-git-send-email-quic_vnivarth@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681313387-8376-3-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/04/2023 17:29, Vijaya Krishna Nivarthi wrote:
> This is done as part of adding DMA support to qspi driver.

Do not use "This commit/patch", but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Best regards,
Krzysztof

