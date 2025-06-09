Return-Path: <linux-spi+bounces-8388-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75337AD1BC6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 12:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C87A1B2F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39519B3CB;
	Mon,  9 Jun 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dd/NTCzR"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085E7E9;
	Mon,  9 Jun 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466041; cv=fail; b=VarBg4YaMNF/8TxvpL+IEBd167vv6bQ+pWVzSxlhmWcMMI/ORupfaSYGfLj/bMFuVLJDaXpMC+fHk72P4D5JaEgcpR9e2txYJB19TixRSE8HA8mJa061oTkefyCHxBsuPRWEuGtJNiv4po7bWnDoYwxtB2skOHwNJF9D4PgMhSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466041; c=relaxed/simple;
	bh=8Scp26sI/vRmxTOa1S7c/M0OpyfStKQvWHXJT1ZIsk4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwrxvgPAgUF6unLXujV8zQP5ftIQDiXDMjnezfiosyoSSGfzyDQAYjOGKWugUqPfo5c5/drU2RbPjhJTwuQtC3x3hkg56yYFGvdLJKpT4cCFUg1z97QwBKNfw2gfPufEiJzKHlBsnQcLUajeD4A0QsUzPfJuv6ccJPQZIivtWyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dd/NTCzR; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMaIZQyFWAiNnBJyNbDZ7rURYskyr00J//duhyyzjBYHR6M8XEW3SXRQpFyD14IQJvYid4GOIZNl2zPGHzrobC3wOcjW/DRdslIbp4yr0T4xw8dOrh7YgIl1al+hkKDSvVOUlKCERhtedQzELoXmOaAK88hRnKeBp15KqNbg8VF761cqV+gpYoHhcYFuBfXZ84XxyPrupv1lmYCbzs0bpmUQEMCZUnFUXCIoiE1q/qekxUTqtvOppTUcMeYgoOOyacMIHqndDsfsXOlQZZ9ylpfb9N0mScpRX5fZ7JnkL51+CSpYtEuOkOGb2a+UQBAD5o45AXSB3vbr7oQmLM1efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBhsasBCVJUbEE2aqs3X+sXqxqaEERuJe0ewquDoKYo=;
 b=e1lpzKSlhJR+eTKfUi9d0ruVrOclFfavp+ghaUNacyhaXreQJKRdZS/KVSAniELosl9QgKcjZ/yQ2/nMwoI314B5N2CiEK5A6CwKcJaxBxrwKTbgYdz6QgO90B6Fot3Q29SVRPbF5wXeqSjsHCzU9RCezoiu9Ei10fgiH8NGoIXyO22NnbXuANNwApA1cboblivzrFLQp5FtXN4ovJiVe0AlJYMRjSSyWMTeWScQtyEErjrs+/ijHN2jKO2lyUVuaVGWxpgn75utxcgCFPsnTWGR4gKwDbQxqedeDYnspK4p/AXmkyiL8S8Z1/Sel8ammv7XowUzgy70VTWmZGklVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBhsasBCVJUbEE2aqs3X+sXqxqaEERuJe0ewquDoKYo=;
 b=dd/NTCzRNK0UOlCCRfHVRS6YrYJp0NZWHHYUd6xShVu/CtwKj6y5I7KoUpLNutwiTa1Jk+KIjUeq1DI9XAL/3vUDRMfVGu5VSmS8hxUZ7D0+Qugo9U/yB6FXcFdUAfKuYvfN6Ajy5iJ3EO6c3/1m8QAK3TeMjqMsbQHWjC5ZwnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 10:47:18 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 10:47:18 +0000
Message-ID: <d3d1e550-c736-4e26-b397-aaeae50bd647@amd.com>
Date: Mon, 9 Jun 2025 16:17:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] spi: spi_amd: Update Kconfig dependencies
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, krishnamoorthi.m@amd.com,
 akshata.mukundshetty@amd.com
References: <20250516100658.585654-1-Raju.Rangoju@amd.com>
 <20250516100658.585654-4-Raju.Rangoju@amd.com>
 <CAMuHMdWTwcoFQz39uF0gJUT=X4yC=wn0gYGU5L+jW_JBj0WnGA@mail.gmail.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <CAMuHMdWTwcoFQz39uF0gJUT=X4yC=wn0gYGU5L+jW_JBj0WnGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0060.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::6) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: aee4af46-4cd0-4e03-004b-08dda74300f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clMyQzZSWkwyUG1DZTlyMXVKc3YyY0tmRGs1MndRM25zcE5LajRlT1ZVVGpk?=
 =?utf-8?B?bDdlYlFxNW14cTJaQUNpeTBlZE5KaGsvc2VwQzVLSlFDTFYyeFphZGtrRzBR?=
 =?utf-8?B?SnVrcUt4aUo3dFc1NkpuNDNkeHhUc1JvMm9OSnp3dTF4YWttcTNQSXNUTTBS?=
 =?utf-8?B?WGgyQy9HbGtwM010aWN2Wml6blAxSFlqZkpGWjBaUlprYzJJN0JqRWc3TVZF?=
 =?utf-8?B?Vm45VG9YdUIwVktyQjU3NmFoSFl2SURtWTNSZkEwcmYxeU8xT1FaeFpjSlE3?=
 =?utf-8?B?QWpwZ1JNbCtraHdaSmtTekJhdkU4Z1ptMENoeFpZOGEzbjFWUEhrY3h2bFY5?=
 =?utf-8?B?bHk0QWQ5b3FxQUNSbkdiSmF6Zi9PWDVOc25XZFB2bkRyaFlkSldJVk1wN1oy?=
 =?utf-8?B?OWNROVQ3TmhTb1dYM3dvTGhnaFpqS084bmYzcFkyV3djNWFod2RLNXpSY3dL?=
 =?utf-8?B?RloydEZLUFlsWnhmZGJzWWoyNzNpYS9EdTBYK0g3V29YNENjM2Z1SmlGY0Iy?=
 =?utf-8?B?bWdGV1p2elJ2V2VlKzkyNEtNT0t4OGc2ZVpGRmYxVG90bk5leWIySmh6Nm5J?=
 =?utf-8?B?eHpSbTVqT0JoNWQweDJkbWJISWVhdnp5eXJvTXlXandrRFVOQkNralZ0em10?=
 =?utf-8?B?Rm1CZWNmcFlqWDF3aFZVSHcwMXl2ZUtGc3FCY09HeWhid3QwTHZCYUFpb0wr?=
 =?utf-8?B?dy9YMEF1OHhSWDlkVWhPTHhPUUVEbkpoT3prMDBEZnlaZGhuVHNqTHdzbGlR?=
 =?utf-8?B?WUJlV2Y3MnhwTVhDZWUyK2k3aEllejRaMjV1ZW5WQjVEOXZvd3FxNTU4UEo1?=
 =?utf-8?B?N3FWdTdHZ1RZazZaeVVFV3cvVlJSNmZpQkliaTZBRWoxdUxGanFZYzJnb3p6?=
 =?utf-8?B?MnR5Mnh6TzNuemhSTnpremlXaitaWjFpN1VzSlRWNFhCdXViaU82TmdJYlhh?=
 =?utf-8?B?bEcxQmtUQnhrYVJtSUthWjdncVNLYWtpTzNQeWNEM1puYXRpVjNJQUpOanlt?=
 =?utf-8?B?T1Vkcmg2SlVMVERXMHozeVUrNHR3alpVbWtVNWxTL3gzcVVFZCs0d3crTFlV?=
 =?utf-8?B?bUE4YmlNLzBLQ29LRVAyU2IrNW43Vml5dGpmcnB1c0Y1SnNtUHFlVU4rVUhT?=
 =?utf-8?B?NVRNaEd5cVlyVXhYUURNOFRFNWE0NFE5YUtnd3NUc3VSUzFoUVhxNDl3dWha?=
 =?utf-8?B?OUw4bUZVTi83UGxaNGlBMTV3cWlma2xUNENzTGwvaDNMNXFWSHhOVzNFTS9C?=
 =?utf-8?B?TUh1SStWeFQ3VWY3Nnl0Tm1IamxtNjlWckh1dFZWQzlzbzNNcGRjWkh6K2Mr?=
 =?utf-8?B?TkJxWnhuWkVTS0N4M1FFVmNyMUZ4MkRySUxubmJUK01kdGdMaG5oYS8zSGVj?=
 =?utf-8?B?NjdyRFRidnpNUGs4Mk56aUJFVmpwUDRoWDNDUUJMTXlNRWFJMzN2b2pkWndM?=
 =?utf-8?B?WGV2MytjZi91UTVhL1NmSytqL1lteTZXWklLOEsvdWZZWm5CVVNlSDAwWWxM?=
 =?utf-8?B?a1I1VjdSYXMreCtXcUtlQndNQ1JRcWttUmEza25KdjVwM1k4ZG9GdGdHbkl3?=
 =?utf-8?B?dlFKZzQ4OU5iV1dGKzRFRXBmVnlndElvcSs1c3d0WDJRSFIxanBQQWJremhG?=
 =?utf-8?B?c3BMQ0E5V1l6N3d2UDBtYTBOMDFrWmpaQWZ3MWhNd3Y4cHF0aEh0RFlTUkxY?=
 =?utf-8?B?WVVic0xXRzNkek9vdDhPTHdTa3FDN3RmSHQ2eE9QTWZlRFN4U0d5by9pZDJU?=
 =?utf-8?B?bUI0dzNKb0tqbDNYNlZpYzhMU0gremovb0kzRHc2eFF1RUJ5Y2NMTmx0WFFk?=
 =?utf-8?B?NStBRUkrVHNyZE5XdjNhckorYWljakZOODJGL1FjeDR3ZlhTTWlCbmF5d1Qz?=
 =?utf-8?B?dDBKQ2dQZ1VtSHQySlZQeEVKL2dreThpeU5uNm1ENmIrOTFCZjRHV1lwVDBC?=
 =?utf-8?Q?erFCnSrWczY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0Y0ZnFNOXptUk45dkVTekhueGpkMi95RDhKMmdDZmZKS01VRDRid3R1Nldx?=
 =?utf-8?B?eHROeHYyQUExQTE0ejdCdVJQS2tMdjB2TkxjT0h1VTVyWW9wemVZaHdadlJs?=
 =?utf-8?B?VWtkYkgvRzRsSXZBanE3NVh3cVJ5WkVXT0M2WnJDK1dKWmdQU1pQREJoblNx?=
 =?utf-8?B?K2xMT1kwM1ZzUkxuOTNxekI3QTdnVkh6VGIwY0xDN3g5eEh4bEtkTmJ3Slh4?=
 =?utf-8?B?ZXROUHVoRFFhRkxJbVR0RTNHOUFub0dDSlAyeiswZExoaUhTREd4b1dEb2Uv?=
 =?utf-8?B?UnNHVXBjWExldTBtZkdabENEVjM1UmFncVhUdUlRK1ZLaS9tTVA4Wk9Icmxu?=
 =?utf-8?B?VzB0c1pFZ1ljMlhIYWNZWjM5dXRhMHpodkxYRnRPbi9yay9lbEp0R1pBam9I?=
 =?utf-8?B?a2NHOCtleVdybXRyOElieDg4NjltMlZQM1VGUC9SL2d3QkN2VUpUM1VOd2Uy?=
 =?utf-8?B?S29POXphVyttWTBlcmJuT25uVU9nYlIyM2luT2RWM256ZFZPbTg5a1FBcEpp?=
 =?utf-8?B?OElQdllpMzFkVm42Y3dmVE9aVTQ3VXBoaUEvN3orUjVXcGNFWnZtN3VRd0hj?=
 =?utf-8?B?RXNXaWFMVSsvcGJmQkhzMXVUYXUySnoxb3cxeENFYlZMb2kzUEVUSElSdFZh?=
 =?utf-8?B?RUgvRkRUR1pLekdDR0R4dFArbjZ5QkRSa0FNTW1OMGh5ci9vZndSVGt6MGx1?=
 =?utf-8?B?THJ5QTNsUndTcDA5TnFWQ093Tnl4SGdCVzNFNFYybWlHRjUzTWg0MXF5QjlR?=
 =?utf-8?B?WU5xQTJWV3lwaktXalBOeWpsWGQ3Z3c1NURXRkxFV2hmODZpL2UyZnI1bWlW?=
 =?utf-8?B?dUNJSzZaSUt3aTdoS0RoUC9ZTENWOFdCZzY0Vis1T01oNmJuWnJEWVFjQXJY?=
 =?utf-8?B?d2l2bWhuVHdvQSsyWmN6R1JiWW1hVWxqcWt4M0VrV1BiVzBoWGRkTWNnRzQ5?=
 =?utf-8?B?S2RpZ1lOOTJZMnZtUi9BZXZHS1UwSisrbVUyZ2MxZWxIaEhGdlNJQUZkdC9i?=
 =?utf-8?B?V1g4SEtHV2xTWGMxQnRJRnhOQjdsczZkK0tTVkh2V2J1clEwWXZBWjl5eVEv?=
 =?utf-8?B?RllhWWl4d1Zjdml2NEFUdUZvbDlsS0lFckpvNXFsaitGTUNYajNVd3RPanRY?=
 =?utf-8?B?VitDL3ZNMjQ4V2Z6QThwUUNJTVUxbDdtMVlyRi80dDZROHBkeVU0c3pDK29x?=
 =?utf-8?B?cUE4RG03TnNsU2dSd3oxS2Qxb1lNeENuTi82V2lpaUdPNHFYcXp1ZTUxS2tt?=
 =?utf-8?B?RmFrNGYzc08rREhFRVUvcEticlRPWTVwOU91cjUzcUF1QW9kNURUd2grNWsx?=
 =?utf-8?B?azZwU3RXTGZLeWhwbkIzN3NNYmVhOWJ1b1pYUk5MUUNDUy90NzN5VjdIOFln?=
 =?utf-8?B?dWl6aUVkVGFKOUpQQk9KSUx1NzhlYThNZXBYNU9OcUQ5MFJlUm5qZkxReVVQ?=
 =?utf-8?B?OFpFZDhxSmMwOC96dEFESFRYSm85Y0FpN00zV1lrWkVxallGSjFiSGludkpD?=
 =?utf-8?B?ZFFsTHpvVTVtRWY5YVpYTXBkR0Z3T0lOelhFUUpDWjErRWh1U08rbXBIWGRT?=
 =?utf-8?B?clhvNmhGQ3BFUTRadTlFazlKSDN6TVBEb2tkcW1YOFJ6VFRsalgwdFVIUXA2?=
 =?utf-8?B?citneFNpNjkxcmdTN21Ma0EyR0VqUGNnVnlzK2lKSHNYblAxbTc0cTU1WDh5?=
 =?utf-8?B?bEZ1eGtzWURobEJMZ1dpcHI4UUFWNENOZktrVVAyRG1jWXBqYmRNdVdJTGxz?=
 =?utf-8?B?YkNrU1BoeHNBT0xON1hGTGtvRkd5SU9HYTNiZ3owaWhqaytlNUFOQ0VnMis4?=
 =?utf-8?B?bnpGeEVkZkNoWE5kT0xST215b1NRYlovaEQvZTU5ZUF2bnVXWlNQa1Bjd0tE?=
 =?utf-8?B?Mko2V05XMHJYM1hjZ2c0dTdiMlVpc1lGdEhBTkJVQ081TGNFMWlpMnR5YnYz?=
 =?utf-8?B?azgxVTRjN09TU3RjdTlMMUF4bCtJYnpoZ1IzemlaR1JOVFhLVXdaeDhzWXZS?=
 =?utf-8?B?eHdCK3oxdGFYblEvTGRkYWV6ejJaVzdlUjhiWW8xZkxjVlBNc2lyVHYyUDhC?=
 =?utf-8?B?V3dhOHNWS2tIZjBOejF6RUIxZjIyenlnODZObnl6NEpDcllObFQwc1Vka1NJ?=
 =?utf-8?Q?7OIF1ndeCKJ9lXBzWGUVqLrW9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee4af46-4cd0-4e03-004b-08dda74300f2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 10:47:18.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezxKojtW6HkD4TEeyLHY8UN8l8k4kEfVj+qCtUDcPwLi9F3YSo8SNUk1CLWfkluTomhHXAH1XeBMnM9bK7gqhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861



On 5/28/2025 1:02 PM, Geert Uytterhoeven wrote:
> Hi Raju,
> 
> Thanks for your patch, which is now commit dbb79974193a2932 ("spi:
> spi_amd: Update Kconfig dependencies") upstream.
> 
> On Fri, 16 May 2025 at 12:09, Raju Rangoju <Raju.Rangoju@amd.com> wrote:
>> Add X86 and SPI_MEM as dependencies for the spi_amd driver to ensure it is
>> built only on relevant platforms and with the required SPI memory
>> framework.
> 
> This sounds like you are restricting the driver further (BTW, what are
> "relevant platforms"?)...

AMD x86 platforms.

> 
>> Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
>> Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -1267,7 +1267,8 @@ config SPI_ZYNQMP_GQSPI
>>   config SPI_AMD
>>          tristate "AMD SPI controller"
>>          depends on PCI
>> -       depends on SPI_MASTER || COMPILE_TEST
>> +       depends on SPI_MASTER || X86 || COMPILE_TEST
> 
> ... but this broadens it instead?
> And how can it be used on X86 if SPI_MASTER=n?
> 
> Seeing an ACPI match table in drivers/spi/spi-amd.c, perhaps you wanted
> to have a dependency on ACPI (or X86 && ACPI) somewhere?
> 
> BTW, as you now have a single Kconfig symbol gating both spi-amd.c
> and spi-amd-pci.c, this means you can no longer build spi-amd.c if
> CONFIG_PCI=n.

Sure Greert. Thanks for the suggestion.
We are planning to have separate Kconfig for both ACPI and PCI based 
drivers in the upcoming series.

> 
>> +       depends on SPI_MEM
>>          help
>>            Enables SPI controller driver for AMD SoC.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


