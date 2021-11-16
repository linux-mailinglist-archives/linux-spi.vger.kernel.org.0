Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C728C452F1C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhKPKeo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 05:34:44 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41474
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234159AbhKPKem (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 05:34:42 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9AA3A4001F
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637058704;
        bh=ThaYp9G+64NxRqKzCKbRUdZxK0rHiWmTIO3o3cKe36Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=A6r6kRWFK0YOERvi8laq3D8GUWKmQKJNYM3p1da9II06kmNVoTkmvIaUrCZIyEUda
         VDl4/gXDt/K4JhN4d+1+h/178yZopCt0lG6RNneyT7y8VtkPAiUj7yXfEWxGETMtvW
         HYNahPFrV57tqZPErYdYKHRHVq7TurULZVWY6aoFAREybvSus41zGa2LEaq15s79dO
         A02pf60bvBEGEXrk0giqkVqzr7o6ERmq3SmLp4HIp29qJ05zUnHCsGgM2kA99sUPRn
         tHr/pFF1j2cwqXYe8rKJNbRQTWGDacJFg+g3W/BARMvBpTKBwos0Qo3bVEHQPCJx0I
         ZdS/LTLVRzO0g==
Received: by mail-lj1-f198.google.com with SMTP id 2-20020a2e0902000000b00218c22336abso6059919ljj.0
        for <linux-spi@vger.kernel.org>; Tue, 16 Nov 2021 02:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThaYp9G+64NxRqKzCKbRUdZxK0rHiWmTIO3o3cKe36Y=;
        b=nfmV4FP747MAuDJMWo6my8TMr+4//hf7g9YP59lhihX05vPXz4yCFq+uUcwE9ac3o+
         sm7JBZHBd/lhc8EYVbdsroGZd6utjis1K8K8Zoh6KTmZqThBgDS1vY3xK7bjn9h8N74o
         gO5zJNNQL7EQeBpXSIJT1bZkBhVB+md4SpXI7dK4LfJMJ94nNlB3Tm3zTjAIxg2SUVD3
         +qWLBMd4eeiLEDoSDf94r3R5VtbKMsGjVY5bHNo4exA6hUKaxt5dr1glbIel97njY7rM
         xn36txplcBxC3kdbJB7/OXDClD5BiLZMcT8eHxIyOmLf5xtuHtyCgmXBCphZG2v4AMfd
         NYDg==
X-Gm-Message-State: AOAM5302kYilMU+HyMF/nuw2hoxvCnaIDnbx1ythZHDR7ZLZgxB1hhjJ
        Sq6INUNMljXH5OWeRJpyt94HSZIIARBvEObbocDsFmYE3y8Xd8ED9tnM9aYl06mtzG8Ol0LUk8y
        7y9jR/R4ecvimNeLt9hedjCU8+VHywaoNl2gdQw==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr5675051lfm.582.1637058703892;
        Tue, 16 Nov 2021 02:31:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0NdatstZNdLBhO99EKL6y8ayUMQay94r9rgDX+32tJqQpGp8oIkn6fRQLxpQq5x6dEdHicg==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr5675035lfm.582.1637058703760;
        Tue, 16 Nov 2021 02:31:43 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id j5sm1114418lfe.219.2021.11.16.02.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 02:31:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 2/7] dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
Date:   Tue, 16 Nov 2021 11:31:03 +0100
Message-Id: <163705866144.26823.12246673489129083312.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211025205631.21151-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20211025205631.21151-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 25 Oct 2021 21:56:26 +0100, Lad Prabhakar wrote:
> For completeness add optional interrupts property.
> 
> 

Applied, thanks!

[2/7] dt-bindings: memory: renesas,rpc-if: Add optional interrupts property
      commit: 4b5a231ff617d5cdc9e99f39a7268ad491400195

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
