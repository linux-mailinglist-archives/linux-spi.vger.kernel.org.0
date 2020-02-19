Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914FF164364
	for <lists+linux-spi@lfdr.de>; Wed, 19 Feb 2020 12:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgBSLas (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Feb 2020 06:30:48 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13866 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgBSLas (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Feb 2020 06:30:48 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JBT4AB005357;
        Wed, 19 Feb 2020 03:30:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=IeN6i9lAkCwSbC/c8Y8FpZ6j02TqHU28TJrlsy9NL3s=;
 b=rMVeBJzA8qusI3jVLTz5yKr6aFu8QftFIRqqt/+FQOLpdjxYAOatOKg/glX/tva5H34A
 atN993TRlD3QdXdx0oR1oXudMscH9C1vz2I4nXFWKyzpf1L3aa2wOjgrpIpmlOtkuWnA
 m5ZB74cR6dm0VV6HNOkVECOKNAQfeJ7E2s3qGEshZ2NA3x81Kw1Ty3mgGQrbAbDMVOkv
 KaFHFJY7KW7fj9+693D7TnrQbw3cUQHPywdT0A2oxH7zwbbG5LFQKiJHRtpMLzY3se1o
 h+qAmOD3M18kcrBK3UriMhD3Yw0tOj65E6c41wiygXN9Q85FaRzwU7D/tRR2FHDzKHvx Fw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2y8uas1rhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 03:30:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjHkMigIlB7vyZJWPI7h13a9E4d3K0/3Vgu/oV8ZAtwtz4q8YH32a/gSynxM3TddxxidcjAzp0io1es67NoW11/iO7GB6Vwj1BOUvxB3evJ5NhSDJO3dtivFnmV97Z4FLxqoDEASx67nGozVKHf7y+7ILpNksu2Ovbi52zILbtsgqSU9uEdg79xZbLaeJP0HeE0PjnsL52xoDfOzP3W2uafW3InhnHjUUHP87BjZmY70Jp6jfR7VeMUhRSDZ2Kejo95837QgzMfqqF2TO2yNZUAFJWnRiMnWkex5lt0FTWRjGk023c92dyvABJnXgmREj7h9nVkEVFaslT88pB1Mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeN6i9lAkCwSbC/c8Y8FpZ6j02TqHU28TJrlsy9NL3s=;
 b=d92X9+ZkIFADLGIy8YSUZ+w+IeyEvlJVF7kN7angBKHk7kRiWlc7yXjMi9sF7xrriQLcVl3xQLjl6HN4mAH4uk9ugnMjKuH5DKTnvAvi3gZbuBv0O72eGmKYEXj11pXUbOSyT9Y+Jw0o3D5ZQs/4hpgpnC8p2Y4HPq5eimJSD97w9QZMSWQg+v1ApYbw6Ce78YJibfW4+53eIr5D06z846Xyftg8qmgKkyPhPLuNawlRNt+1948ZhjkikfVZjGDE2uWEtPw+xdwy1P9xg2rqAgjRqrvh4q8qFw1GA6XTm5bsSDMMd8cf56SVsxzdBOi5eEmriscV7rB2LIgA/lCxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeN6i9lAkCwSbC/c8Y8FpZ6j02TqHU28TJrlsy9NL3s=;
 b=mZD4CcvnA1kW1yB/2NSsyAWWAdpyyGTWfqqd3/qiebaINKZJeYKBNigGpZbZt3Dxq3IDH/ER/5nuOL39lwcyEpdlC2COlkd7bcjFpxvARFcVYOxXmTfwXZ1mIjT9DzVRouyhIrkcK13c1MpVEd40k2VKK/+ipt7czYpAQjsLTAs=
Received: from CY1PR07CA0003.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::13) by DM6PR07MB5369.namprd07.prod.outlook.com
 (2603:10b6:5:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Wed, 19 Feb
 2020 11:30:39 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by CY1PR07CA0003.outlook.office365.com
 (2a01:111:e400:c60a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Wed, 19 Feb 2020 11:30:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12 via Frontend Transport; Wed, 19 Feb 2020 11:30:38 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 01JBUMN8021529
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 19 Feb 2020 06:30:36 -0500
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 03:30:32 -0800
Date:   Wed, 19 Feb 2020 12:30:29 +0100
From:   Konrad Kociolek <konrad@cadence.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Add dt-bindings for Cadence XSPI controller
Message-ID: <20200219113028.GA3092@global.cadence.com>
References: <20200128124313.12837-1-konrad@cadence.com>
 <20200205183114.GA23752@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200205183114.GA23752@bogus>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36092001)(199004)(189003)(336012)(54906003)(6916009)(86362001)(26826003)(7696005)(478600001)(2906002)(1076003)(26005)(70206006)(426003)(956004)(356004)(6666004)(8936002)(186003)(81166006)(55016002)(5660300002)(70586007)(8676002)(16526019)(6286002)(33656002)(81156014)(316002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5369;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abecc18-1eec-4cac-70fe-08d7b52f2517
X-MS-TrafficTypeDiagnostic: DM6PR07MB5369:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5369E0D2D356532A8B1B36CBC3100@DM6PR07MB5369.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0318501FAE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yowj5sl33Ktlz8f4sx+h/CXT0hOuyGS6x3PZ89EkUmt7WzHtcLQzeO4YAXS+yvycijtZ/h5fhxwPhnoyPzMYDZtYi92IGISZuS1OjG4BxeRvVjEobCIUmwhKRlHxQxJdDgck1lBqGfUvqaWNrIWVkDDlXFBbHlrh5dRaFZO3RMsXBV4ZD8eTpXPpK+krxD8SdKg36yLvXC3iT8Ckn6+HsUiKdAkcgET3w311W5S5NDOG8+T5ozyCHz33Q8EU1GmKts803ow1jhfp2GSPhMpOPoBkBU1KuKARIYXu/CI55ewZ0UHeRXQV7/c4VPApDffS/JLIwnPFplDGLaY1VlanxQ2gF8LRMu5SVSO9XxPtWmGW+ho+8UPRCZDNU6jS2UXOrHLvhXr6oGiszn1JbzNcIJez6T+wx6QMlOjL2ZxHHFPPn8npWCKVRKv+G/dZT6GDrsUtbeecqYowYLiPOlrEY7zNTSdMC4Du4+j1okqWhfvOg1oldteaXreh0v481e7kFvy4235q4dArkzC/IKr3g4BjRv8yfO87Phz3xWnSIswMzorUPhEy718+eINTSI3n
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 11:30:38.5079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abecc18-1eec-4cac-70fe-08d7b52f2517
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5369
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_03:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190087
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 02/05/2020 18:31, Rob Herring wrote:
>EXTERNAL MAIL
>
>
>On Tue, Jan 28, 2020 at 01:43:04PM +0100, Konrad Kociolek wrote:
>> Add dt-bindings documentation for Cadence XSPI controller to support
>> SPI based flash memories.
>>
>> Signed-off-by: Konrad Kociolek <konrad@cadence.com>
>> ---
>> Changes between initial version and v2:
>>   - renamed yaml file
>>   - added missing include
>>
>>  .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 +++++++++++++++++++++
>>  1 file changed, 166 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>> new file mode 100644
>> index 000000000000..e8c43957fd90
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>> @@ -0,0 +1,166 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
>
>Dual license new bindings:
>
>(GPL-2.0-only OR BSD-2-Clause)
>
>> +# Copyright 2020 Cadence
>> +%YAML 1.2
>> +---
>> +$id: "https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_schemas_spi_cdns-2Cxspi.yaml-23&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=G7iI7AW4JEOXbx13Fe5B7uVPtTH6HSiaA_R5uR2HQjY&m=vgq1v6AC47kHEnD4BGadbiavRIW3wUjNWfh5fCNtivI&s=5GznvYUXU7Lk0eHcHCnJAsz0aKwZmZqEsGGo5A9i2l8&e= "
>> +$schema: "https://urldefense.proofpoint.com/v2/url?u=http-3A__devicetree.org_meta-2Dschemas_core.yaml-23&d=DwIBAg&c=aUq983L2pue2FqKFoP6PGHMJQyoJ7kl3s3GZ-_haXqY&r=G7iI7AW4JEOXbx13Fe5B7uVPtTH6HSiaA_R5uR2HQjY&m=vgq1v6AC47kHEnD4BGadbiavRIW3wUjNWfh5fCNtivI&s=pm5-krCiP_J-P48RO4mlub5ARy9eGOBfV59k8d02Q4g&e= "
>> +
>> +title: Cadence XSPI Controller
>> +
>> +maintainers:
>> +  - Konrad Kociolek <konrad@cadence.com>
>> +
>> +description: |
>> +  The XSPI controller allows SPI protocol communication in
>> +  single, dual, quad or octal wire transmission modes for
>> +  read/write access to slaves such as SPI-NOR flash.
>> +
>
>Needs a ref to spi-controller.yaml
>
>> +properties:
>> +  compatible:
>> +    const: cdns,xspi-nor-fpga
>> +
>> +  reg:
>> +    maxItems: 3
>> +    description: |
>> +      Contains three entries, each of which is a tuple consisting of a
>> +      physical address and length. The first entry is the address and
>> +      length of the controller register set. The second entry is the
>> +      address and length of the Slave DMA data port. The third entry is
>> +      the address and length of auxiliary registers.
>
>Split into 3 descriptions:
>
>items:
>  - description: ...
>  - description: ...
>  - description: ...
>
>With that, drop 'maxItems' as it is implied.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  cdns,dqs-last-data-drop:
>> +    type: boolean
>> +    description: |
>> +      This parameter should be set when the Flash Device being used
>> +      issues data on negative edge of Flash clock and returns them with
>> +      DQS and the PHY is configured to sample data in DQS mode.
>> +      If this param is set the controller internally requests this redundant
>> +      data at the end of the transfer cleaning up the PHY FIFO.
>> +
>> +  cdns,phy-data-select-oe-start:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the starting point of the DQ pad output enable window.
>> +      Lower numbers pull the rising edge earlier in time and larger
>> +      numbers cause the rising edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-data-select-oe-end:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the ending point of the DQ pad output enable window.
>> +      Lower numbers pull the falling edge earlier in time and larger
>> +      numbers cause the falling edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-dqs-select-oe-start:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the starting point of the DQS pad output enable window.
>> +      Lower numbers pull the rising edge earlier in time and larger
>> +      numbers cause the rising edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-dqs-select-oe-end:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Adjusts the ending point of the DQS pad output enable window.
>> +      Lower numbers pull the falling edge earlier in time and larger
>> +      numbers cause the falling edge to be delayed. Each bit changes
>> +      the output enable time by a 1/2 cycle resolution.
>> +
>> +  cdns,phy-gate-cfg-close:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Normally the gate is closing then all bits of dfi_cebar are high
>> +      or when dfi_rd_pre_post_amble and rebar_dfi are high. This parameter
>> +      allows to extend the closing of the DQS gate. Recommended zero.
>> +
>> +  cdns,phy-gate-cfg:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Coarse adjust of gate open time. This value is the number of cycles
>> +      to delay the dfi_rddata_en signal prior to opening the gate in
>> +      full cycle increments. Decreasing this value pulls the gate earlier
>> +      in time. This field should be programmed such that the gate signal
>> +      lands in the valid DQS gate window.
>> +
>> +  cdns,phy-rd-del-select:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Defines the read data delay. Holds the number of cycles to delay
>> +      the dfi_rddata_en signal prior to enabling the read FIFO.
>> +      After this delay, the read pointers begin incrementing the read FIFO.
>> +
>> +  cdns,phy-clk-wr-delay:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: |
>> +      Controls the clk_wr delay line which adjusts the write DQ bit
>> +      timing in 1/256th steps of the clock period in normal DLL
>> +      locked mode. In bypass mode this field directly programs
>> +      the number of delay elements.
>
>For all of these, any constraints on the values? default?
>
>> +
>> +  cdns,phy-use-lpbk-dqs:
>> +    type: boolean
>> +    description: |
>> +      This parameter chooses lpbk_dqs to capture data for reads.
>> +      Instead memory DQS will be used.
>> +
>> +  cdns,phy-use-ext-lpbk-dqs:
>> +    type: boolean
>> +    description: |
>> +      This parameter chooses external lpbk_dqs for data capture
>> +      (lpbk_dqs connected to the lpbk_dqs_IO pad). When not used
>> +      mem_rebar_pad is used for data read capture.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - cdns,phy-data-select-oe-start
>> +  - cdns,phy-data-select-oe-end
>> +  - cdns,phy-dqs-select-oe-start
>> +  - cdns,phy-dqs-select-oe-end
>> +  - cdns,phy-gate-cfg-close
>> +  - cdns,phy-gate-cfg
>> +  - cdns,phy-rd-del-select
>> +  - cdns,phy-clk-wr-delay
>
>Is there no sensible default to make these optional?
>
Those parameters depend on connected flash memory, used FPGA board,
memory adapter and must be adjusted by user, to make memory
communication working.
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    xspi: spi@a0010000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        compatible = "cdns,xspi-nor-fpga";
>> +        reg = <0x0 0xa0010000 0x0 0x10000>,
>> +              <0x0 0xb0000000 0x0 0x10000>,
>> +              <0x0 0xa0020000 0x0 0x10000>;
>> +        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-parent = <&gic>;
>> +        cdns,dqs-last-data-drop;
>> +        cdns,phy-data-select-oe-start = <0>;
>> +        cdns,phy-data-select-oe-end = <4>;
>> +        cdns,phy-dqs-select-oe-start = <0>;
>> +        cdns,phy-dqs-select-oe-end = <1>;
>> +        cdns,phy-gate-cfg-close = <3>;
>> +        cdns,phy-gate-cfg = <0>;
>> +        cdns,phy-rd-del-select = <5>;
>> +        cdns,phy-clk-wr-delay = <64>;
>> +        cdns,phy-use-lpbk-dqs;
>> +        cdns,phy-use-ext-lpbk-dqs;
>> +        mt35xu512@0 {
>
>flash@0
>
>> +            compatible = "spi-nor", "micron,mt35xu512";
>
>Wrong order. Most specific first.
>
>> +            spi-max-frequency = <75000000>;
>> +            reg = <0>;
>> +        };
>> +        mt35xu512@1 {
>
>flash@1
>
>> +            compatible = "spi-nor", "micron,mt35xu512";
>> +            spi-max-frequency = <75000000>;
>> +            reg = <1>;
>> +        };
>> +    };
>> --
>> 2.15.0
>>

-- 
--
Konrad Kociolek
